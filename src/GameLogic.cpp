#include "GameLogic.h"


extern QCoreApplication *coreApp;

GameLogic::GameLogic(QObject *parent) :
    QObject(parent),
    m_state(NO_CHECKED),
    m_lastAction(NO_ACTION),
    m_settings(this),
    m_analytics(new GAnalytics(coreApp, "UA-64996589-1"))
{
    initialize();
}

GameLogic::~GameLogic()
{
    m_analytics->endSession();
}

void GameLogic::saveNumsList()
{
    saveNums();
}

void GameLogic::checkCell(int pos)
{
    if(m_nums.length() <= pos)
        return;
    checkedCell_1 = &m_nums[pos];
    m_state = ONE_CELL_CHECKED;
}

void GameLogic::checkSolution()
{
    m_calc.checkSolutionStart(&m_nums);
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
    Cell p;
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
    m_lastAction = NEXT_STEP;
    b_nums = m_nums;

    m_calc.nextStepStart(&b_nums, &m_nums);

    setSteps(m_steps+1);

}

void GameLogic::restart()
{
    m_analytics->sendAppview(QCoreApplication::applicationName(), QCoreApplication::applicationVersion(), "New Game");
    m_lastAction = NO_ACTION;
    m_nums.clear();
//    m_nums.append(1);    m_nums.append(1);    m_nums.append(1);    m_nums.append(2);
//    m_nums.append(1);    m_nums.append(1);    m_nums.append(3);    m_nums.append(0);
//    m_nums.append(0);
//    m_nums.append(3);    m_nums.append(1);    m_nums.append(6);
//    m_nums.append(1);    m_nums.append(7);    m_nums.append(1);    m_nums.append(8);
//    m_nums.append(1);    m_nums.append(9);
    m_nums.append(1);    m_nums.append(1);    m_nums.append(1);    m_nums.append(2);
    m_nums.append(1);    m_nums.append(3);    m_nums.append(1);    m_nums.append(4);
    m_nums.append(1);    m_nums.append(5);    m_nums.append(1);    m_nums.append(6);
    m_nums.append(1);    m_nums.append(7);    m_nums.append(1);    m_nums.append(8);
    m_nums.append(1);    m_nums.append(9);
    m_time = 0;
    m_steps = 0;
    m_score = 0;
    m_settings.clear();
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
        setSteps(m_steps-1);

        saveNums();

        break;
    case DEL_NUMS:
        foreach (Cell p, b_pairs) {
            m_nums.replace(p.pos, p.value);
        }
        b_pairs.clear();
        m_score -= SCORE_CONSTANT;
        m_settings.setValue("Score", m_score);
        saveNums();
        emit scoreChanged();
        break;
    default:
        return;
    }
    emit numsChanged();

    m_lastAction = NO_ACTION;
}

bool GameLogic::haveSaves()
{
    if(m_settings.contains("Time")      ||
       m_settings.contains("Steps")     ||
       m_settings.contains("Score")     ||
       m_settings.contains("NumList"))
        return true;
    else
        return false;
}

void GameLogic::openQmlPage(QString namePage)
{
    m_analytics->sendAppview(QCoreApplication::applicationName(), QCoreApplication::applicationVersion(), namePage);
}

QString GameLogic::appName()
{
    return QCoreApplication::applicationName();
}

QString GameLogic::appVersion()
{
    return QCoreApplication::applicationVersion();
}

QString GameLogic::appMail()
{
    return QCoreApplication::organizationDomain();
}

QString GameLogic::appAuthor()
{
    return QCoreApplication::organizationName();
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
        m_settings.setValue("Time", arg);
        emit timeChanged();
    }
}


void GameLogic::setSteps(int arg)
{
    if (m_steps != arg) {
        m_steps = arg;
        m_settings.setValue("Steps", arg);
        emit stepsChanged();
    }
}

void GameLogic::setScore(int arg)
{
    if (m_score != arg) {
        m_score = arg;
        m_settings.setValue("Score", arg);
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

void GameLogic::loadNums()
{
    int size = m_settings.beginReadArray("Nums");
    m_nums.clear();
    m_nums.reserve(size);
    for (int i = 0; i < size; ++i) {
        m_settings.setArrayIndex(i);
        m_nums.append(m_settings.value("digit").toInt());
    }
    emit numsChanged();
}

void GameLogic::saveNums()
{
//    m_settings.set
    m_settings.setValue("NumList", 0);
    m_settings.beginWriteArray("Nums");
    for(int i = 0; i < m_nums.size(); i++){
        m_settings.setArrayIndex(i);
        m_settings.setValue("digit", m_nums.at(i));
    }
    m_settings.endArray();
}

void GameLogic::nextStepSlot()
{
    if(m_nums.length() == 0){
        emit endGame();
        return;
    }
    saveNums();
    emit numsChanged();
}

void GameLogic::initialize()
{
    m_analytics->generateUserAgentEtc();

    m_analytics->setAppName(QCoreApplication::applicationName());

    connect(&m_calc, &AsyncCalc::haveNotSolution, this, &GameLogic::haveNotSolution);
    connect(&m_calc, &AsyncCalc::solutionSig, this, &GameLogic::haveSolution);
    connect(&m_calc, &AsyncCalc::nextStepSig, this, &GameLogic::nextStepSlot);

    m_time = m_settings.value("Time", 0).toInt();
    m_steps = m_settings.value("Steps", 0).toInt();
    m_score = m_settings.value("Score", 0).toInt();

    if(m_settings.contains("NumList")){
        loadNums();
        saveNums();
    }
    else{
        m_nums.append(1);    m_nums.append(1);    m_nums.append(1);    m_nums.append(2);
        m_nums.append(1);    m_nums.append(3);    m_nums.append(1);    m_nums.append(4);
        m_nums.append(1);    m_nums.append(5);    m_nums.append(1);    m_nums.append(6);
        m_nums.append(1);    m_nums.append(7);    m_nums.append(1);    m_nums.append(8);
        m_nums.append(1);    m_nums.append(9);
    }

}

