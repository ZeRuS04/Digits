#ifndef GAMELOGIC_H
#define GAMELOGIC_H

#include <QObject>
#include <QSettings>
#include "AsyncCalc.h"

#define NO_CHECKED          (0)
#define ONE_CELL_CHECKED    (1)


#define NO_ACTION           (0)
#define NEXT_STEP           (1)
#define DEL_NUMS            (2)

#define SCORE_CONSTANT      (10)

struct Pair{
    int pos;
    int value;
};


class GameLogic : public QObject
{
    Q_OBJECT
    int m_time;
    QList<int> m_nums;

    QList<int> b_nums;
    QList<Pair> b_pairs;
    AsyncCalc calc_;
    int m_steps;
    int m_score;
    int m_state;

    int m_lastAction;
    int *checkedCell_1;
    QSettings m_settings;


public:
    explicit GameLogic(QObject *parent = 0);
    Q_PROPERTY(int time READ time WRITE setTime NOTIFY timeChanged)
    Q_PROPERTY(int score READ score WRITE setScore NOTIFY scoreChanged)
    Q_PROPERTY(int steps READ steps WRITE setSteps NOTIFY stepsChanged)

    Q_PROPERTY(int numsCount READ numsCount NOTIFY numsChanged)
    Q_PROPERTY(int state READ state WRITE setState NOTIFY stateChanged)

    Q_INVOKABLE void    saveNumsList();
    Q_INVOKABLE void    checkCell(int pos);
    Q_INVOKABLE int     getNum(int i);
    Q_INVOKABLE void    numToNull(int i);
    Q_INVOKABLE bool    checkPair(int pos1, int pos2);
    Q_INVOKABLE void    nextStep();
    Q_INVOKABLE void    restart();
    Q_INVOKABLE void    undo();

    int time() const;
    int steps() const;
    int score() const;
    int numsCount() const;
    int state() const;

signals:
    void timeChanged();
    void numsChanged();
    void stepsChanged();
    void scoreChanged();
    void endGame();
    void stateChanged();

public slots:
    void setTime(int arg);
    void setSteps(int arg);
    void setScore(int arg);
    void setState(int arg);
    void loadNums(QList<int> retVal);
    void saveNums(QStringList retVal);
    void nextStepSlot();
};

#endif // GAMELOGIC_H
