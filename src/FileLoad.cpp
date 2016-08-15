#include "FileLoad.h"
#include "ui_FileLoad.h"

#include <QFile>
#include <QFileDialog>
#include <QMessageBox>
#include <QTextStream>
#include <QDebug>

FileLoad::FileLoad(QWidget *parent) :
  QDialog(parent),
  m_ui(new Ui::FileLoad)
{
  m_ui->setupUi(this);

  // create main window when needed
  m_mainWindow = new UserInterface(this);
}

FileLoad::~FileLoad()
{
  delete m_ui;
}

// Get the file being pointed to in the text entry field and load into TextEdit
void FileLoad::on_loadScript_clicked()
{ 
  QString filePath = m_ui->filePath->toPlainText();

  QFile simFile (filePath);

  // If read fails flag up a warning
  if(!simFile.open(QIODevice::ReadOnly))
  {
    QMessageBox::information(0,"Error",simFile.errorString());
  }

  // Get the contents of the file
  QTextStream in(&simFile);

  m_ui->luaViewer->setText(in.readAll());

  m_simFilePath = filePath.toUtf8().constData();

  simFile.flush();
  simFile.close();

}


// retrieve the path of a script file for use in the sim
void FileLoad::on_getFilePath_clicked()
{
    // Close the MainWindow to avoid a bug with the dialog
    m_mainWindow->close();

    // Does not work correctly in this format
    QString fileName = QFileDialog::getOpenFileName(nullptr,
       tr("Open Lua"), "/home/", tr("Lua Source File (*.lua)"));

    // Set the text field to the file path retrieved, unless it is empty
    if (!fileName.isEmpty())
    {
      m_ui->filePath->setText(fileName.toUtf8().constData());

      // Load in contents automatically
      on_loadScript_clicked();
    }
}


// write the cntents of the text box back into the file
void FileLoad::on_runScript_clicked()
{
  m_mainWindow->show();
  m_mainWindow->m_gl->m_flock->m_luaSimScript = m_simFilePath;
}

void FileLoad::on_saveScript_clicked()
{
  QString filePath = m_ui->filePath->toPlainText();

  if (filePath.isEmpty())
  {
    filePath = QFileDialog::getSaveFileName(nullptr,
           tr("Save Lua"), "/home/", tr("Lua Source File (*.lua)"));

    m_ui->filePath->setText(filePath.toUtf8().constData());
  }

  QFile simFile (filePath);

  // If write fails, flag up a warning
  if(!simFile.open(QIODevice::WriteOnly))
  {
    QMessageBox::information(0,"Error",simFile.errorString());
  }

  // Text is transferred via TextStream
  QTextStream out(&simFile);
  out << m_ui->luaViewer->toPlainText();

  // If a new file has been created, the correct path needs to be retrieved.
  m_simFilePath = filePath.toUtf8().constData();

  simFile.flush();
  simFile.close();
}
