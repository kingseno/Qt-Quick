#include "service.h"

Service::Service(QObject* parent) : QObject(parent)
{

}

void Service::openService(int id){
    switch (id) {
        case 0:{
            QString link = "https://www.nhaccuatui.com/";
            QDesktopServices::openUrl(QUrl(link));
            break;
        }
        case 1:{
            QString link = "https://mp3.zing.vn/";
            QDesktopServices::openUrl(QUrl(link));
            break;
        }
        case 3:{
            QString link = "http://keeng.vn/";
            QDesktopServices::openUrl(QUrl(link));
            break;
        }
        case 2:{
            QString link = "https://nhac.vn/";
            QDesktopServices::openUrl(QUrl(link));
            break;
        }
        case 4:{
            QString link = "https://youtube.com/";
            QDesktopServices::openUrl(QUrl(link));
            break;
        }
        case 5:{
            QString link = "http://imuzik.viettel.vn/";
            QDesktopServices::openUrl(QUrl(link));
            break;
        }
        default:
            break;

    }
}
