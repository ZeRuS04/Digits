#ifndef ASYNCCALC_H
#define ASYNCCALC_H

#include <QThread>
#include <QStringList>

#define I_TO_S      (1)
#define S_TO_I      (2)
#define NEXT_STEP   (3)
class AsyncCalc : public QThread
{
    Q_OBJECT

    void run();
public:
    explicit AsyncCalc(QObject *parent = 0);
    void listStringToIntStart(QStringList arg);
    void listIntToStringStart(QList<int> arg);
    void nextStepStart(QList<int> *arg1, QList<int> *arg2);
signals:
    void listStringToIntSig(QList<int> retVal);
    void listIntToStringSig(QStringList retVal);
    void nextStepSig();
public slots:

private:
    void listStringToInt();
    void listIntToString();
    void nextStep();

    QList<int> arg_i;
    QStringList arg_s;
    QList<int> *b_nums;
    QList<int> *m_nums;
    int param_;
};

#endif // ASYNCCALC_H
