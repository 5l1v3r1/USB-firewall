VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "U�̷���ǽ -- (Ӳ�����鿴��)"
   ClientHeight    =   5370
   ClientLeft      =   150
   ClientTop       =   840
   ClientWidth     =   7485
   Icon            =   "Form1.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   5370
   ScaleWidth      =   7485
   StartUpPosition =   3  '����ȱʡ
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   5880
      Top             =   5040
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Timer Timer1 
      Interval        =   20
      Left            =   5400
      Top             =   5040
   End
   Begin VB.FileListBox File1 
      Height          =   4050
      Hidden          =   -1  'True
      Left            =   3360
      MultiSelect     =   2  'Extended
      Pattern         =   "*"
      System          =   -1  'True
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   600
      Width           =   3975
   End
   Begin VB.DirListBox Dir1 
      Height          =   4080
      Left            =   120
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   600
      Width           =   3135
   End
   Begin VB.DriveListBox Drive1 
      Height          =   300
      Left            =   120
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   120
      Width           =   3135
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "Label3"
      Height          =   180
      Left            =   3360
      TabIndex        =   5
      Top             =   240
      Width           =   540
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Label2"
      Height          =   180
      Left            =   3360
      TabIndex        =   3
      Top             =   0
      Width           =   540
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Label1"
      Height          =   180
      Left            =   120
      TabIndex        =   2
      Top             =   4800
      Width           =   540
   End
   Begin VB.Menu Doing 
      Caption         =   "���ļ��Ĳ���"
      Visible         =   0   'False
      Begin VB.Menu Run 
         Caption         =   "����"
      End
      Begin VB.Menu Nothing4 
         Caption         =   "-"
      End
      Begin VB.Menu Delete 
         Caption         =   "ɾ��"
      End
      Begin VB.Menu Copy 
         Caption         =   "����"
      End
      Begin VB.Menu Move 
         Caption         =   "�ƶ�"
      End
      Begin VB.Menu Nothing 
         Caption         =   "-"
      End
      Begin VB.Menu NewFile 
         Caption         =   "ˢ��"
      End
      Begin VB.Menu Nothing1 
         Caption         =   "-"
      End
      Begin VB.Menu PutOntheProc 
         Caption         =   "��ָ���ĳ����"
      End
      Begin VB.Menu PutOnNotebook 
         Caption         =   "�ü��±���"
      End
   End
   Begin VB.Menu DoingBack 
      Caption         =   "���ļ��еĲ���"
      Visible         =   0   'False
      Begin VB.Menu Back 
         Caption         =   "����"
      End
      Begin VB.Menu OpenBack 
         Caption         =   "��"
      End
      Begin VB.Menu Create 
         Caption         =   "�½�"
      End
      Begin VB.Menu DeleteBack 
         Caption         =   "ɾ��"
      End
      Begin VB.Menu Nothing2 
         Caption         =   "-"
      End
      Begin VB.Menu NewDrive 
         Caption         =   "ˢ����Ŀ¼"
      End
      Begin VB.Menu NewBack 
         Caption         =   "ˢ���ļ���"
      End
   End
   Begin VB.Menu File 
      Caption         =   "�ļ�  "
      Begin VB.Menu Scan 
         Caption         =   "ɨ�����д���"
         Shortcut        =   ^S
      End
      Begin VB.Menu Write 
         Caption         =   "�޸�©��"
         Enabled         =   0   'False
         Shortcut        =   ^M
      End
      Begin VB.Menu Nothing3 
         Caption         =   "-"
      End
      Begin VB.Menu Abuot 
         Caption         =   "����"
         Shortcut        =   ^A
      End
   End
   Begin VB.Menu DriveData 
      Caption         =   "Ӳ������  "
      Begin VB.Menu Look 
         Caption         =   "�鿴"
         Shortcut        =   ^L
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function GetFileType Lib "kernel32" (ByVal hFile As Long) As Long     ''�жϸ��ļ�����
Private Declare Function lopen Lib "kernel32" Alias "_lopen" (ByVal lpPathName As String, ByVal iReadWrite As Long) As Long      ''��
Private Declare Function lclose Lib "kernel32" Alias "_lclose" (ByVal hFile As Long) As Long      ''�ر�
Private Declare Function PathFileExists Lib "shlwapi.dll" Alias "PathFileExistsA" (ByVal pszPath As String) As Boolean    '�ж��ļ��Ƿ������ĳһ��Ŀ¼
Private Declare Function GetDriveType Lib "kernel32" Alias "GetDriveTypeA" (ByVal nDrive As String) As Long     ''�жϸô�������
Private Declare Function DeleteFile Lib "kernel32" Alias "DeleteFileA" (ByVal lpFileName As String) As Long     ''ɾ���ļ�
Private Declare Function RemoveDirectory Lib "kernel32" Alias "RemoveDirectoryA" (ByVal lpPathName As String) As Long     ''ɾ���ļ���

Private Sub File1_DblClick()       ''''   ( Can doing)   [ But ...it don't start some Proc]
On Error Resume Next
 Dim Name As String
 Name = LCase(Mid(File1.FileName, InStr(File1.FileName, ".") + 1))   ''+1��Ϊ�˲���ʾ"."��
 If Name = "exe" Or Name = "bat" Then
 Shell File1.Path & "\" & File1.FileName, vbNormalFocus
 ElseIf Name = "txt" Or Name = "dat" Or Name = "ini" Or Name = "inf" Then
 Shell "notepad.exe " + File1.Path & "\" & File1.FileName, vbNormalFocus
 ElseIf Name = "html" Or Name = "htm" Or Name = "xml" Then
 Shell "iexplorer " + File1.Path & "\" & File1.FileName
 Else
 MsgBox "�޷����� " + "." + Name + "�ļ�"
 End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
End
End Sub

'''''               �κλ�û�о�����ȷ���еĴ���ŵ�����
'''''                    ( Can Doing Datch )

''''  #######################33    �˵�����
''''  #########################
''''  #######################33    �˵� -> ���ļ��Ĳ���

Private Sub Move_Click()       ''''   ( Can doing)
On Error GoTo a:
If File1.ListIndex = -1 Then MsgBox "��û����File����ѡһ���ļ��ƶ���": Exit Sub
Dim Path As String
Path = InputBox("������������Ҫ�ƶ�����·��", "�ƶ��ļ���", Dir1.Path)
If Path = "" Then MsgBox "������һ����ȷ��·��": Exit Sub
If (MsgBox("���Ҫ�ƶ���" + Path + "����?", vbQuestion, "�ƶ��ļ���") = vbOK) Then
Call FileCopy(File1.List(File1.ListIndex), Path & "\" & File1.List(File1.ListIndex))  '''��һ�����ļ���,������Ŀ���ļ�
Kill (Dir1.Path & "\" & File1.List(File1.ListIndex))    ''���ø���/ɾ���Ļ���
Label2.Caption = "���ļ����¹���:" & File1.ListCount & "������"
File1.Refresh   ''ˢ�¿ؼ�   ( ���������Ū�Ļ�,�ؼ������Զ�ˢ�� )
Exit Sub
End If

a:
MsgBox "·����Ч"
End Sub

Private Sub Copy_Click()     ''''   ( Can doing)
On Error GoTo a:
If File1.ListIndex = -1 Then MsgBox "��û����File����ѡһ���ļ�������": Exit Sub
Dim Path As String
Path = InputBox("������������Ҫ���Ƶ���·��", "�����ļ���", Dir1.Path)
If Path = "" Then MsgBox "������һ����ȷ��·��": Exit Sub
If (MsgBox("���Ҫ���Ƶ�" + Path + "  ����?", vbQuestion, "�����ļ���") = vbOK) Then
Call FileCopy(File1.List(File1.ListIndex), Path & "\" & File1.List(File1.ListIndex)) '''��һ�����ļ���,������Ŀ���ļ�
Exit Sub
End If

a:
MsgBox "·����Ч"
End Sub

Private Sub Run_Click()      ''''   ( Can doing)
File1_DblClick
End Sub

Private Sub Delete_Click()      ''''   ( Can doing)
On Error Resume Next
DeleteFile (Dir1.Path & "\" & File1.FileName)
Label2.Caption = "���ļ����¹���:" & File1.ListCount & "������"
File1.Refresh    ''ˢ�¿ؼ�   ( ���������Ū�Ļ�,�ؼ������Զ�ˢ�� )
End Sub

Private Sub Create_Click()     ''''   ( Can doing)
Dim Name
Name = InputBox("������һ���ļ���")
If Name = "" Then
MsgBox "��Ч�ļ���"
Exit Sub
ElseIf Name = 0 Then
Exit Sub
End If
MkDir (Name)    ''����һ���ļ���
Dir1.Refresh   ''ˢ�¿ؼ�   ( ���������Ū�Ļ�,�ؼ������Զ�ˢ�� )
End Sub


Private Sub PutOnNotebook_Click()      ''''   ( Can doing)
On Error GoTo a:
Shell "notepad.exe " + File1.Path & "\" & File1.FileName, vbNormalFocus
Exit Sub

a:
MsgBox "û�м��±�"
End Sub

Private Sub PutOntheProc_Click()      ''''   ( Can doing)
On Error Resume Next
Dim OpenProcPath As String
  CommonDialog1.ShowOpen
  If CommonDialog1.FileName = "" Then Exit Sub
  OpenProcPath = CommonDialog1.FileName
Shell OpenProcPath & " " & File1.Path & "\" & File1.FileName, vbNormalFocus
End Sub

''''  #######################33    �˵� -> ���ļ��Ĳ���
''###############      ˢ�¿ؼ�

Private Sub NewDrive_Click()       ''''   ( Can doing)
Drive1.Refresh
End Sub

Private Sub NewBack_Click()      ''''   ( Can doing)
Dir1.Refresh
End Sub

Private Sub NewFile_Click()      ''''   ( Can doing)
File1.Refresh
End Sub

''###############      ˢ�¿ؼ�

''''  #######################33    �˵� -> ���ļ��еĲ���

Private Sub Back_Click()       ''''   ( Can doing)
On Error Resume Next
Dir1.Path = Dir1.List(-2)   ''-1�Ǳ���,-2����һ��
End Sub

Private Sub OpenBack_Click()        ''''   ( Can doing)
Dir1.Path = Dir1.List(Dir1.ListIndex)
End Sub

Private Sub DeleteBack_Click()      ''''   ( Can doing)
On Error GoTo a:
MsgBox Dir1.List(Dir1.ListIndex)
RmDir (Dir1.List(Dir1.ListIndex))    ''���ļ����й��İ�ʱ����ɾ��
Dir1.Refresh     ''ˢ�¿ؼ�   ( ���������Ū�Ļ�,�ؼ������Զ�ˢ�� )
Exit Sub

a:
Dim NowDirectory As String
NowDirectory = CurDir
Reset
If RemoveDirectory(Dir1.List(Dir1.ListIndex)) = 0 Then MsgBox "ɾ��ʧ��"
ChDir (NowDirectory)
End Sub


''''  #######################33    �˵� -> ���ļ��еĲ���

Private Sub Scan_Click()       ''''   ( Can doing)
On Error Resume Next
Dim RootDisk As String
RootDisk = Drive1.Drive
Dim Directory As String
Directory = Dir1.Path
Reset

For i = 65 To 90
If PathFileExists(Chr(i) & ":\Autorun.inf") Then Warning Chr(i) & ":\Autorun.inf", Chr(i) & "\"
Next

MsgBox "����ɨ�����,δ���ִ��ڵ���в", vbOKOnly, "OK"
Drive1.Drive = RootDisk
Dir1.Path = Directory
End Sub

Private Sub Abuot_Click()       ''''   ( Can doing)
MsgBox "U�̷���ǽ" + vbCrLf + "��" + CStr(App.Major) + "." + CStr(App.Minor) + "." + CStr(App.Revision) + "��" + vbCrLf, vbOKOnly, "���ڲ�Ʒ"
End Sub

Private Sub Look_Click()      ''''   ( Can doing)
Form2.Show
End Sub


''''  #######################33    �˵�����
''''  #########################

''''  #########################    �ļ��ؼ�����
''''  #########################

Private Sub Dir1_Change()      ''''   ( Can doing)
ChDir (Dir1.Path)                  '''�����������������Ļ�,GetFileType�Ͳ���׼ȷ������
File1.Path = Dir1.Path
Dir1.ToolTipText = Dir1.Path
Label2.Caption = "���ļ����¹���:" & File1.ListCount & "������"   ''��ʾ�������
Call FindAutorun    ''���ļ���λ�øı�ʱѰ���Ƿ���AutoRun.inf�������
End Sub

Private Sub Dir1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)        ''''   ( Can doing)
If Button = 2 Then
 If Dir1.List(-2) = "" Then
 Back.Enabled = False
 Else
 Back.Enabled = True
 End If
 
 If Dir1.ListIndex = -1 Then
 OpenBack.Enabled = False
 Else
 OpenBack.Enabled = True
 End If
 
Me.PopupMenu DoingBack    ''��ʾ�ļ��в˵�
End If
End Sub

Private Sub Drive1_Change()       ''''   ( Can doing)         <--- Calling FindAutorun
On Error GoTo a:
Dir1.Path = Drive1.List(Drive1.ListIndex)
Exit Sub

a:
MsgBox "�豸������"
End Sub

Private Sub File1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Error Resume Next
If Button = 1 Then File1.ToolTipText = File1.Path & File1.FileName & " -- " & FileType(File1.FileName, File1.Path, Drive1.Drive)
If File1.Selected(File1.ListIndex) = True Then     ''  �����File1����ѡ��һ��Ļ�
If Button = 2 Then     ''������µ����Ҽ�
Me.PopupMenu Doing        ''��ʾ�ļ��˵�
End If
End If
End Sub


''''  #########################    �ļ��ؼ�����
''''  #########################

Private Sub Form_Load()       ''''   ( Can doing)
Label2.Caption = "���ļ����¹���:" & File1.ListCount & "������"    ''��ʾ�������
Dir1.ToolTipText = Dir1.Path
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)       ''''   ( Can doing)
Drive1.Refresh
Dir1.Refresh
File1.Refresh
End Sub


Private Sub Timer1_Timer()       ''''   ( Can doing)         <--- Calling DrivaType()
Label1.Caption = Dir1.Path   ''��ʾ��ǰ���ļ���·��
Label3.Caption = "���ļ����¹���:" & Dir1.ListCount & "���ļ���"   ''��ʾ�������
Call DriveType(Drive1.Drive)
End Sub

Private Sub DriveType(ByVal RootPath As String)     '''' ���ظ��̵�����      ( Can doing)
On Error Resume Next
Dim Drive As String
Drive = Trim(Left(RootPath, InStr(RootPath, "[") - 1))
If Drive = "" Then Drive = RootPath

Dim ReturnCode As Long
ReturnCode = GetDriveType(Drive)
If ReturnCode = 1 Then
Drive1.ToolTipText = RootPath + " ϵͳ����"
ElseIf ReturnCode = 2 Then
Drive1.ToolTipText = RootPath + " ���ƶ�����"
ElseIf ReturnCode = 3 Then
Drive1.ToolTipText = RootPath + " ���ش���"
ElseIf ReturnCode = 5 Then
Drive1.ToolTipText = RootPath + " CD-ROM"
ElseIf ReturnCode = 6 Then
Drive1.ToolTipText = RootPath + " RAM"
End If
End Sub

Private Function FileType(ByVal FileName As String, ByVal Path As String, ByVal Drive As String) As String '''' �����ļ�������      ( Can doing)
ChDrive (Drive)
ChDir (Path)
Dim rCode As Long
Dim FileHwnd As Long
FileHwnd = lopen(FileName, 0)
rCode = GetFileType(FileHwnd)
If rCode = 1 Then
FileType = FileName + " �����ļ�,���ش���:" & rCode
ElseIf rCode = 2 Then
FileType = FileName + " ����̨���ӡ���ļ�,���ش���:" & rCode
ElseIf rCode = 3 Then
FileType = FileName + " �ܵ��ļ�,���ش���:" & rCode
Else
FileType = FileName + " δ֪�ļ�,���ش���:" & rCode
End If

lclose (FileHwnd)
End Function

Private Sub FindAutorun()       '''' Ѱ��File�����Ƿ��� AutoRun -->����ѭ�����  ( Can doing)
Dim i As Integer
For i = 0 To File1.ListCount - 1    ''����Ǹ��ǿ���
Dim Name As String
Name = Trim(LCase(File1.List(i)))
Dim PathName, Path As String
PathName = Trim(File1.Path & "\" & File1.List(i))
Path = Trim(File1.Path)
If Name = "autorun.inf" Then
 Call Warning(PathName, Path)
End If
Next
End Sub

''############################################
''############################################   AutoRun ���ļ����ݲ鿴����

Private Function AutoRunFindAnging(ByVal PathName As String) As String          ''''   ( Can doing)
On Error Resume Next
Dim ReturnCode As String
Dim Line As Long
Line = 0

Open PathName For Input As #1

Do While True
If EOF(1) = True Then Exit Do
Line = Line + 1
Dim Str As String
Line Input #1, Str
Dim Code As String
Code = CodeEqu(Str)
If Code <> "" Then ReturnCode = ReturnCode + CodeEqu(Str) + "   ��: " + CStr(Line) + " ��" + vbCrLf

Loop

Close
AutoRunFindAnging = ReturnCode
End Function

Private Function CodeEqu(ByVal Str As String) As String           ''''   ( Can doing)
On Error Resume Next
Dim Back As String
Dim Value As String


Back = LCase(Trim(Left(Str, (InStrB(Str, "=") - 1) \ 2))) ''instr - 1 ����������ȡ����
Value = Trim(Mid(Str, InStr(Str, "=") + 1))   ''ͬ��,�������ʽ����

''''   AutoRun .inf �Ĺؼ�����
''''   �ù�����ʱ�ṩ���͹ؼ���Ϣ
Dim AutoRun As String
AutoRun = "AutoRun �к���  "
If Back = "" Or Value = "" Then Exit Function

If Back = "action" Then
AutoRun = AutoRun + Back + "  ����,ָ�� " + Value
CodeEqu = AutoRun
ElseIf Back = "icon" Then
AutoRun = AutoRun + Back + "  ����,ָ�� " + Value
CodeEqu = AutoRun
ElseIf Back = "label" Then
AutoRun = AutoRun + Back + "  ����,ָ�� " + Value
CodeEqu = AutoRun
ElseIf Back = "open" Then

DeleteFile (Value)
AutoRun = AutoRun + Back + "  ����,ָ�� " + Value
CodeEqu = AutoRun
ElseIf Back = "useautoplay" Then
AutoRun = AutoRun + Back + "  ����,ָ�� " + Value
CodeEqu = AutoRun
ElseIf Back = "shellexecute" Then
AutoRun = AutoRun + Back + "  ����,ָ�� " + Value
CodeEqu = AutoRun
ElseIf Back = "shell" Then
AutoRun = AutoRun + Back + "  ����,ָ�� " + Value
CodeEqu = AutoRun
ElseIf InStr(Back, "shell") > 0 Then

DeleteFile (Value)
AutoRun = AutoRun + Back + "  ����,ָ�� " + Value
CodeEqu = AutoRun
End If

End Function

''############################################   AutoRun ���ļ����ݲ鿴����
''############################################

Private Sub Warning(ByVal PathName As String, ByVal Path As String)       ''''   ( Can doing)
On Error GoTo del:

Dim rCode As String
rCode = AutoRunFindAnging(PathName)
If rCode = "" Then
If (MsgBox("���� ��" + vbCrLf + "��" + Path + "�º���AutoRun " + vbCrLf + "ɾ��ô", vbExclamation Or vbOKCancel, "��鵽AutoRun") = vbOK) Then
DeleteFile (PathName)
File1.Refresh   ''ˢ��һ�£���Ȼ�Ļ��û�����ã��
End If
Exit Sub

Else
 If (MsgBox("���� ��" + vbCrLf + "��" + Path + "�º���AutoRun " + vbCrLf + "������AutoRun������" + vbCrLf + vbCrLf + rCode + vbCrLf + vbCrLf + "�����ܻ�����ĵ�����Σ��" + vbCrLf + vbCrLf + "�Ƿ�ɾ�� ??", vbExclamation Or vbOKCancel, "��鵽AutoRun", 0, 0) = vbOK) Then
  DeleteFile (PathName)    ''ɾ��AutoRun
  File1.Refresh   ''ˢ��һ�£���Ȼ�Ļ��û�����ã��
 End If
End If

Exit Sub

del:
MsgBox "ɾ������"
File1.Refresh
End Sub

''����ѭ����ȡFile���ļ�
Private Sub ShowProc()      '''  ʵ������-->��������ѭ�����ȡFile�е�����
Dim i As Integer
Dim Proc As String
For i = 1 To File1.ListCount
Proc = Proc + File1.List(i) + Chr(10)
Next
Label2.ToolTipText = Proc
End Sub

