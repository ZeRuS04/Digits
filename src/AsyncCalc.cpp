#include "AsyncCalc.h"


void AsyncCalc::run()
{
    switch (m_param) {
    case N_STEP:
        nextStep();
        break;
    case HAVE_SOLUTION:
        checkSolution();
        break;
    default:
        return;
    }

}

AsyncCalc::AsyncCalc(QObject *parent) :
    QThread(parent),
    m_param(0)
{
}

void AsyncCalc::nextStepStart(QList<int> *arg1, QList<int> *arg2)
{
    b_nums = arg1;
    m_nums = arg2;
    m_param = N_STEP;
    start();
}

void AsyncCalc::checkSolutionStart(QList<int> *arg1)
{
    m_nums = arg1;
    m_param = HAVE_SOLUTION;
    start();
}

void AsyncCalc::checkSolution()
{
    // Проверим на наличие решений:
    bool haveSolution = false;
    for(int i = 0; i < m_nums->size(); i++){
        if(m_nums->at(i) == 0)
            continue;
        int linesCount = m_nums->size()/9;
        if(m_nums->size()%9 > 0)
            linesCount++;

        // найдем цифру слева
        int leftBound = i - ((i%9));
        int t = i-1;
        while(t >= leftBound){
            if((m_nums->at(t) == m_nums->at(i)) || ((m_nums->at(t) + m_nums->at(i)) == 10)){
                haveSolution = true;
                emit solutionSig(t, i);
                break;
            }
            if(m_nums->at(t) != 0)
                break;
            t--;
        }
        if(haveSolution)
            break;


        // найдем цифру справа
        int rightBound = (i - ((i%9))) + 8;
        if(rightBound >= m_nums->size())
            rightBound = m_nums->size()-1;
        t = i+1;
        while(t <= rightBound){
            if((m_nums->at(t) == m_nums->at(i)) || ((m_nums->at(t) + m_nums->at(i)) == 10)){
                haveSolution = true;
                emit solutionSig(t, i);
            }
            if(m_nums->at(t) != 0)
                break;
            t++;
        }
        if(haveSolution)
            break;


        // найдем цифру сверху
        int topBound = 0;

        t = i-9;
        while(t >= topBound){
            if((m_nums->at(t) == m_nums->at(i)) || ((m_nums->at(t) + m_nums->at(i)) == 10)){
                haveSolution = true;
                emit solutionSig(t, i);
            }
            if(m_nums->at(t) != 0)
                break;
            t-=9;
        }
        if(haveSolution)
            break;

        // найдем цифру снизу
        int bottomBound = m_nums->size()/9;
        if(i%9 <= m_nums->size()%9)
            bottomBound++;

        t = i+9;
        while(t <= bottomBound){
            if((m_nums->at(t) == m_nums->at(i)) || ((m_nums->at(t) + m_nums->at(i)) == 10)){
                haveSolution = true;
                emit solutionSig(t, i);
            }
            if(m_nums->at(t) != 0)
                break;
            t+=9;
        }
        if(haveSolution)
            break;
    }
    if(!haveSolution)
        emit haveNotSolution();
}

void AsyncCalc::nextStep()
{
    *b_nums = *m_nums;
    // Пройдем по всем строкам
    for(int k = 0; k < m_nums->length(); k+=9){
        //если первый    элемент в строке нулевой
        if(m_nums->at(k) == 0){
            //переходим к следующему элементу
            // и так до конца строки
            for(int i = k+1; i < k+9; i++){
                //если встретили не нулевой элемент или дошли до конца списка
                if((i >= m_nums->size()) || (m_nums->at(i) != 0)){
                    //переходим к след. строке
                    break;
                }
                //если дошли до последнего элемента
                if(i == k+8){
                    //удалим все элементы в строке
                    while(i>=k){
                        m_nums->removeAt(i);
                        i--;
                    }
                   k-=9;
                }
            }
            emit nextStepSig();
        }
    }

    //скопируем все цифры в конец
    QList<int> nums(*m_nums);
    foreach(int n, nums){
        if(n != 0)
            m_nums->append(n);
    }
    emit nextStepSig();

}

