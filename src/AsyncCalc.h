#ifndef ASYNCCALC_H
#define ASYNCCALC_H

#include <QThread>
#include <QStringList>

#define N_STEP          (0)
#define HAVE_SOLUTION   (1)

class AsyncCalc : public QThread
{
    Q_OBJECT

    void run();
public:
    explicit AsyncCalc(QObject *parent = 0);
    void nextStepStart(QList<int> *arg1, QList<int> *arg2);
    void checkSolutionStart(QList<int> *arg1);
signals:
    void nextStepSig();
    void solutionSig(int pos1, int pos2);
    void haveNotSolution();
public slots:

private:
    void nextStep();
    void checkSolution();

    QList<int> arg_i;
    QStringList arg_s;
    QList<int> *b_nums;
    QList<int> *m_nums;
    int m_param;
};

#endif // ASYNCCALC_H
