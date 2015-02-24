#include "GameLogic.h"

GameLogic::GameLogic(QObject *parent) :
    QObject(parent),
    m_time(0),
    m_steps(0),
    m_score(0),
    m_state(NO_CHECKED),
    m_lastAction(NO_ACTION)
{
//    int mass[2] = ;
    m_nums.append(1);    m_nums.append(1);    m_nums.append(1);    m_nums.append(2);
    m_nums.append(1);    m_nums.append(3);    m_nums.append(1);    m_nums.append(4);
    m_nums.append(1);    m_nums.append(5);    m_nums.append(1);    m_nums.append(6);
    m_nums.append(1);    m_nums.append(7);    m_nums.append(1);    m_nums.append(8);
    m_nums.append(1);    m_nums.append(9);

    /*m_nums = */m_settings.value("NumsList", QVariant(m_nums)).toList();

}

void GameLogic::checkCell(int pos)
{
    if(m_nums.length() <= pos)
        return;
    checkedCell_1 = &m_nums[pos];
    m_state = ONE_CELL_CHECKED;
}

int GameLogic::getNum(int i)
{
    if(m_nums.length() <= i)
        return -1;
    return m_nums.at(i);
}

void GameLogic::numToNull(int i)
{
    if(m_nums.length() <= i)
        return;

    m_lastAction = DEL_NUMS;
    if(b_pairs.length() == 2)
        b_pairs.clear();
    Pair p;
    p.pos = i;
    p.value = m_nums.at(i);
    b_pairs.append(p);

    m_nums.replace(i, 0);
}

bool GameLogic::checkPair(int pos1, int pos2)
{
    int col1 = pos1%9;
    int col2 = pos2%9;
    int row1 = pos1/9;
    int row2 = pos2/9;

    if((m_nums.at(pos1) != m_nums.at(pos2)) &&
     (((m_nums.at(pos1) +  m_nums.at(pos2))!= 10)))
        return false;                           // числа разные и не дают в сумме 10

    if((col1 == col2)&& (row1 == row2))
        return false;
    int dx, i;
    if(row1 == row2){       // на одной строке


        dx = col1-col2;              // расстояние между клетками
        i = col2 + dx/abs(dx);
        while(i != col1){
            if((m_nums.at(row2*9 + i) != 0)){
                // встретили не нулевой элемент между выделеными элементами
                return false;
            }
            i +=   dx/abs(dx);
        }

        return true;
    }

    if(col1 == col2){       // в одной колонке


        dx = row1-row2;              // расстояние между клетками
        i = row2 + dx/abs(dx);
        while(i != row1){
            if((m_nums.at(i*9 + col2) != 0)){
                // встретили не нулевой элемент между выделеными элементами
                return false;
            }
            i +=   dx/abs(dx);
        }

        return true;
    }

    return false;
}

void GameLogic::nextStep()
{
    int k = 0;
    m_lastAction = NEXT_STEP;
    b_nums = m_nums;

    for(int k = 0; k < m_nums.length(); k+=9){
        if(m_nums.at(k) == 0){
            for(int i = k+1; i < k+9; i++){
                if(m_nums.at(i) != 0)
                    break;
                if(i == k+8){
                    while(i!=k){
                        m_nums.removeAt(i);
                        i--;
                    }
                   k-=9;
                }
            }
        }
    }

    QList<int> nums(m_nums);
    foreach(int n, nums){
        if(n != 0)
            m_nums.append(n);
    }
    emit numsChanged();

    //    rep.model = nums;
}

void GameLogic::restart()
{
    m_lastAction = NO_ACTION;
    m_nums.clear();
    m_nums.append(1);    m_nums.append(1);    m_nums.append(1);    m_nums.append(2);
    m_nums.append(1);    m_nums.append(3);    m_nums.append(1);    m_nums.append(4);
    m_nums.append(1);    m_nums.append(5);    m_nums.append(1);    m_nums.append(6);
    m_nums.append(1);    m_nums.append(7);    m_nums.append(1);    m_nums.append(8);
    m_nums.append(1);    m_nums.append(9);
    m_time = 0;
    m_steps = 0;
    m_score = 0;
    m_state = NO_CHECKED;
    emit numsChanged();
    emit timeChanged();
    emit stepsChanged();
    emit scoreChanged();
}

void GameLogic::undo()
{
    switch (m_lastAction) {
    case NO_ACTION:
        return;

    case NEXT_STEP:
        m_nums = b_nums;
        b_nums.clear();
        break;
    case DEL_NUMS:
        foreach (Pair p, b_pairs) {
            m_nums.replace(p.pos, p.value);
        }
        b_pairs.clear();
        m_score -= SCORE_CONSTANT;
        emit scoreChanged();
        break;
    default:
        return;
    }
    emit numsChanged();
    m_lastAction = NO_ACTION;
}

int GameLogic::time() const
{
    return m_time;
}

int GameLogic::steps() const
{
    return m_steps;
}

int GameLogic::score() const
{
    return m_score;
}

int GameLogic::numsCount() const
{
    return m_nums.length();
}

int GameLogic::state() const
{
    return m_state;
}

void GameLogic::setTime(int arg)
{
    if (m_time != arg) {
        m_time = arg;
        emit timeChanged();
    }
}


void GameLogic::setSteps(int arg)
{
    if (m_steps != arg) {
        m_steps = arg;
        emit stepsChanged();
    }
}

void GameLogic::setScore(int arg)
{
    if (m_score != arg) {
        m_score = arg;
        emit scoreChanged();
    }
}

void GameLogic::setState(int arg)
{
    if (m_state != arg) {
        m_state = arg;
        emit stateChanged();
    }
}
