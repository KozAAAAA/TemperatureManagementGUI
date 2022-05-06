#include "worker.h"

Worker::Worker() : QThread()
{

}

void Worker::run()
{
    emit mySignal();
    //for(;;)
    //{}
}
