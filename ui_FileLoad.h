/********************************************************************************
** Form generated from reading UI file 'FileLoad.ui'
**
** Created by: Qt User Interface Compiler version 5.5.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_FILELOAD_H
#define UI_FILELOAD_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QDialog>
#include <QtWidgets/QGridLayout>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QTextEdit>

QT_BEGIN_NAMESPACE

class Ui_FileLoad
{
public:
    QGridLayout *gridLayout;
    QTextEdit *luaViewer;
    QPushButton *loadScript;
    QPushButton *getFilePath;
    QTextEdit *filePath;
    QPushButton *runScript;
    QPushButton *saveScript;

    void setupUi(QDialog *FileLoad)
    {
        if (FileLoad->objectName().isEmpty())
            FileLoad->setObjectName(QStringLiteral("FileLoad"));
        FileLoad->resize(817, 681);
        gridLayout = new QGridLayout(FileLoad);
        gridLayout->setObjectName(QStringLiteral("gridLayout"));
        luaViewer = new QTextEdit(FileLoad);
        luaViewer->setObjectName(QStringLiteral("luaViewer"));

        gridLayout->addWidget(luaViewer, 0, 0, 1, 3);

        loadScript = new QPushButton(FileLoad);
        loadScript->setObjectName(QStringLiteral("loadScript"));

        gridLayout->addWidget(loadScript, 1, 0, 1, 3);

        getFilePath = new QPushButton(FileLoad);
        getFilePath->setObjectName(QStringLiteral("getFilePath"));

        gridLayout->addWidget(getFilePath, 4, 2, 1, 1);

        filePath = new QTextEdit(FileLoad);
        filePath->setObjectName(QStringLiteral("filePath"));
        filePath->setMinimumSize(QSize(0, 30));
        filePath->setMaximumSize(QSize(16777215, 30));
        filePath->setFocusPolicy(Qt::WheelFocus);
        filePath->setFrameShape(QFrame::StyledPanel);
        filePath->setVerticalScrollBarPolicy(Qt::ScrollBarAlwaysOff);
        filePath->setHorizontalScrollBarPolicy(Qt::ScrollBarAsNeeded);

        gridLayout->addWidget(filePath, 4, 0, 1, 1);

        runScript = new QPushButton(FileLoad);
        runScript->setObjectName(QStringLiteral("runScript"));

        gridLayout->addWidget(runScript, 5, 0, 1, 3);

        saveScript = new QPushButton(FileLoad);
        saveScript->setObjectName(QStringLiteral("saveScript"));

        gridLayout->addWidget(saveScript, 2, 0, 1, 3);


        retranslateUi(FileLoad);

        QMetaObject::connectSlotsByName(FileLoad);
    } // setupUi

    void retranslateUi(QDialog *FileLoad)
    {
        FileLoad->setWindowTitle(QApplication::translate("FileLoad", "Lua Editor", 0));
        loadScript->setText(QApplication::translate("FileLoad", "Load/Reload Script", 0));
        getFilePath->setText(QApplication::translate("FileLoad", "Get File Path", 0));
        runScript->setText(QApplication::translate("FileLoad", "Run Script", 0));
        saveScript->setText(QApplication::translate("FileLoad", "Save Script", 0));
    } // retranslateUi

};

namespace Ui {
    class FileLoad: public Ui_FileLoad {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_FILELOAD_H
