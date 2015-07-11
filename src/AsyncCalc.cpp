#include "AsyncCalc.h"


void AsyncCalc::run()
{
    switch (param_) {
    case N_STEP:
        nextStep();
        break;
    default:
        return;
    }

}

AsyncCalc::AsyncCalc(QObject *parent) :
    QThread(parent),
    param_(0)
{
}

void AsyncCalc::nextStepStart(QList<int> *arg1, QList<int> *arg2)
{
    b_nums = arg1;
    m_nums = arg2;
    param_ = N_STEP;
    start();
}

void AsyncCalc::nextStep()
{
    *b_nums = *m_nums;
//    int count = m_nums->length();
    for(int k = 0; k < m_nums->length(); k+=9){
        if(m_nums->at(k) == 0){
            for(int i = k+1; i < k+9; i++){

                if((m_nums->at(i) != 0) || (m_nums->size() >= i)){
                    break;
                }

                if(i == k+8){
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

    QList<int> nums(*m_nums);
    foreach(int n, nums){
        if(n != 0)
            m_nums->append(n);
    }
//    m_settings.setValue("NumsList", listIntToString(m_nums));
    emit nextStepSig();
}

