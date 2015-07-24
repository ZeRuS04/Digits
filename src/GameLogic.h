#ifndef GAMELOGIC_H
#define GAMELOGIC_H

#include <QObject>
#include <QSettings>
#include <QCoreApplication>
#include "AsyncCalc.h"
#include "GAnalitics.h"

#define		APP_NAME	"Digits"
#define		ORG_NAME    "Eugeniy Sinelshchikov"
#define		ORG_DOMAIN	"zerus04@gmail.com"

#define     G_RELEASE	"1"
#define     G_VERSION(x) ("v" G_RELEASE "." x)



#define NO_CHECKED          (0)
#define ONE_CELL_CHECKED    (1)

#define NO_ACTION           (0)
#define NEXT_STEP           (1)
#define DEL_NUMS            (2)

#define SCORE_CONSTANT      (10)

struct Cell{
    int pos;
    int value;
};




class GameLogic : public QObject
{
    Q_OBJECT
    int m_time;
    QList<int> m_nums;
//    QList<QList<int> > m_nums;

    QList<int> b_nums;
//    QList<QList<int> > b_nums;
    QList<Cell> b_pairs;
    AsyncCalc m_calc;
    int m_steps;
    int m_score;
    int m_state;

    int m_lastAction;
    int *checkedCell_1;

    QSettings m_settings;
    GAnalytics *m_analytics;



public:
    explicit GameLogic(QObject *parent = 0);
    ~GameLogic();
    Q_PROPERTY(int time READ time WRITE setTime NOTIFY timeChanged)
    Q_PROPERTY(int score READ score WRITE setScore NOTIFY scoreChanged)
    Q_PROPERTY(int steps READ steps WRITE setSteps NOTIFY stepsChanged)

    Q_PROPERTY(int numsCount READ numsCount NOTIFY numsChanged)
    Q_PROPERTY(int state READ state WRITE setState NOTIFY stateChanged)


//    Q_INVOKABLE QList<int>     line(int i);
    Q_INVOKABLE void    saveNumsList();
    Q_INVOKABLE void    checkCell(int pos);
    Q_INVOKABLE void    checkSolution();
    Q_INVOKABLE int     getNum(int i);
    Q_INVOKABLE void    numToNull(int i);
    Q_INVOKABLE bool    checkPair(int pos1, int pos2);
    Q_INVOKABLE void    nextStep();
    Q_INVOKABLE void    restart();
    Q_INVOKABLE void    undo();


    Q_INVOKABLE bool    haveSaves();
    Q_INVOKABLE void    openQmlPage(QString namePage);

    Q_INVOKABLE QString appName();
    Q_INVOKABLE QString appVersion();
    Q_INVOKABLE QString appMail();
    Q_INVOKABLE QString appAuthor();

    int time() const;
    int steps() const;
    int score() const;
    int numsCount() const;
    int state() const;

    void loadNums();
    void saveNums();
signals:
    void timeChanged();
    void numsChanged();
    void stepsChanged();
    void scoreChanged();
    void endGame();
    void stateChanged();

    void haveSolution(int pos1, int pos2);
    void haveNotSolution();

public slots:
    void setTime(int arg);
    void setSteps(int arg);
    void setScore(int arg);
    void setState(int arg);
    void nextStepSlot();

private:
    void initialize();

};

#endif // GAMELOGIC_H
