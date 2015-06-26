VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Form2 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form2"
   ClientHeight    =   4545
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3975
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4545
   ScaleWidth      =   3975
   StartUpPosition =   3  '����ȱʡ
   Begin MSComctlLib.ProgressBar ProgressBar2 
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   3600
      Width           =   3735
      _ExtentX        =   6588
      _ExtentY        =   450
      _Version        =   393216
      Appearance      =   1
      Scrolling       =   1
   End
   Begin MSComctlLib.ProgressBar ProgressBar1 
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   3000
      Width           =   3735
      _ExtentX        =   6588
      _ExtentY        =   450
      _Version        =   393216
      Appearance      =   1
      Scrolling       =   1
   End
   Begin VB.DriveListBox Drive1 
      Height          =   300
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3735
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "ʣ��ռ�"
      Height          =   180
      Left            =   120
      TabIndex        =   5
      Top             =   3360
      Width           =   720
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "���ÿռ�"
      Height          =   180
      Left            =   120
      TabIndex        =   4
      Top             =   2760
      Width           =   720
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Drive's Stat"
      Height          =   180
      Left            =   120
      TabIndex        =   1
      Top             =   600
      Width           =   1080
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function GetDiskFreeSpace Lib "kernel32" Alias "GetDiskFreeSpaceA" (ByVal lpRootPathName As String, lpSectorsPerCluster As Long, lpBytesPerSector As Long, lpNumberOfFreeClusters As Long, lpTtoalNumberOfClusters As Long) As Long
Private Declare Function GetDriveType Lib "kernel32" Alias "GetDriveTypeA" (ByVal nDrive As String) As Long     ''�жϸô�������


Private Sub Drive1_Change()
LookAt
End Sub

Private Sub Form_Load()
LookAt
End Sub

Private Sub LookAt()
On Error Resume Next
Dim Drive As String
Drive = Trim(Left(Drive1.Drive, InStr(Drive1.Drive, "[") - 1))
If Drive = "" Then Drive = Drive1.Drive
Dim SectorsPerCluster As Long
Dim BytesPerSector As Long
Dim NumberOfFreeClusters As Long
Dim TtoalNumberOfClusters As Long

Call GetDiskFreeSpace(Drive, SectorsPerCluster, BytesPerSector, NumberOfFreeClusters, TtoalNumberOfClusters)

Label1.Caption = DriveType(Drive1.Drive) & vbCrLf & "����:" & vbCrLf & vbCrLf
Label1.Caption = Label1.Caption & "�ܴ���: " & TtoalNumberOfClusters & " ��" & vbCrLf
Label1.Caption = Label1.Caption & "ʣ�����: " & NumberOfFreeClusters & " ��" & vbCrLf
Label1.Caption = Label1.Caption & "ÿ����������: " & SectorsPerCluster & " ��" & vbCrLf
Label1.Caption = Label1.Caption & "ÿ�������ֽ���: " & BytesPerSector & " �ֽ�" & vbCrLf & vbCrLf
Dim TtoalNumberOfClustersByte As Double
TtoalNumberOfClustersByte = CDbl(TtoalNumberOfClusters) * CDbl(SectorsPerCluster) * CDbl(BytesPerSector)
Label1.Caption = Label1.Caption & "���ֽ�: " & CStr(TtoalNumberOfClustersByte) & " �ֽ�  " & Sizes(TtoalNumberOfClustersByte) & vbCrLf
Dim NumberOfClustersByte As Double
NumberOfClustersByte = CDbl(NumberOfFreeClusters) * CDbl(SectorsPerCluster) * CDbl(BytesPerSector)
Label1.Caption = Label1.Caption & "ʣ���ֽ�: " & CStr(NumberOfClustersByte) & " �ֽ�  " & Sizes(NumberOfClustersByte) & vbCrLf
Dim Last As Double
Last = TtoalNumberOfClustersByte - NumberOfClustersByte
Label1.Caption = Label1.Caption & "�����ֽ�: " & CStr(Last) & " �ֽ�  " & Sizes(Last)

ProgressBar1.Max = TtoalNumberOfClustersByte
ProgressBar1.Value = Last
ProgressBar1.ToolTipText = "�����ֽ�: " & CStr(Last) & " �ֽ�  " & Sizes(Last)
ProgressBar2.Max = TtoalNumberOfClusters
ProgressBar2.Value = NumberOfFreeClusters
ProgressBar2.ToolTipText = "ʣ���ֽ�: " & CStr(NumberOfClustersByte) & " �ֽ�  " & Sizes(NumberOfClustersByte) & v
End Sub

Private Function Sizes(ByVal size As Double) As String
If size >= 1024 Then
size = size / 1024
Else
Sizes = Left(size, 5) & "B"
Exit Function
End If

If size >= 1024 Then
size = size / 1024
Else
Sizes = Left(size, 5) & "KB"
Exit Function
End If

If size >= 1024 Then
size = size / 1024
Else
Sizes = Left(size, 5) & "MB"
Exit Function
End If

If size >= 1024 Then
size = size / 1024
Else
Sizes = Left(size, 5) & "GB"
Exit Function
End If

If size >= 1024 Then
size = size / 1024
Else
Sizes = Left(size, 5) & "TB"
Exit Function
End If

End Function

Private Function DriveType(ByVal RootPath As String) As String     '''' ���ظ��̵�����      ( Can doing)
On Error Resume Next
Dim Drive As String
Drive = Trim(Left(RootPath, InStr(RootPath, "[") - 1))
If Drive = "" Then Drive = RootPath

Dim ReturnCode As Long
ReturnCode = GetDriveType(Drive)
If ReturnCode = 1 Then
DriveType = RootPath + " ϵͳ����"
ElseIf ReturnCode = 2 Then
DriveType = RootPath + " ���ƶ�����"
ElseIf ReturnCode = 3 Then
DriveType = RootPath + " ���ش���"
ElseIf ReturnCode = 4 Then
DriveType = RootPath + " �������"
ElseIf ReturnCode = 5 Then
DriveType = RootPath + " CD-ROM"
ElseIf ReturnCode = 6 Then
DriveType = RootPath + " RAM"
End If
End Function

