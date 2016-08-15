#ifndef FILELOAD_H
#define FILELOAD_H

#include <QDialog>
#include <memory>

#include "UserInterface.h"
#include "Flock.h"

/// @file FileLoad.h
/// @brief Defines pointers and private slots for FileLoad.
/// @class FileLoad
/// @author Luke Bazalgette
/// @version 1.0
/// @date 08/08/16
/// @brief This independant class manages a dialog box.
/// Through this dialogue, users can view and edit the Lua script from inside the program.
/// This was done to correct a bug in Qt which does no allow OpenGL to run at the same time as a dialog box.

namespace Ui {
class FileLoad;
}

class FileLoad : public QDialog
{
  Q_OBJECT

public:
  explicit FileLoad(QWidget *parent = 0);
  ~FileLoad();

  std::string m_simFilePath; //!< File path to be loaded into the Flock class

  Ui::FileLoad *m_ui;//!< Dialog object
  UserInterface *m_mainWindow;//!< MainWindow object

private slots:
  void on_loadScript_clicked();//!< Load or reload a script in the filepath box
  void on_getFilePath_clicked();//!< Open a file dialog to locate the script to use
  void on_runScript_clicked();//!< Open a MianWindow with a selected script

  void on_saveScript_clicked();//!<Save text in the entry field to the selected file
};

#endif // FILELOAD_H
