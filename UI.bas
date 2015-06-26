Attribute VB_Name = "UI"
Private Declare Function Shell_NotifyIconA Lib "shell32.dll" (ByVal dwMessage As Long, pnid As NOTIFYICONDATA) As Boolean
Private Type NOTIFYICONDATA
cbSize As Long             ''  �ṹ��С
hwnd As Long               ''  ���
uId As Long                ''  �ṹID
uFlags As Long             ''  ���ݸ��ṹ�ı�־
uCallbackMessage As Long   ''  �ص���Ϣ
hIcon As Long              ''  Icon���(�ڴ��ַ)
szTip As String * 64       ''  Ҫ��ʾ����Ϣ���ڵ���Ϣ
dwState As Long            ''  ״̬
dwStateMask As Long        ''  ״̬����
szInfo As String * 256     ''  ������ʾ����Ϣ
uTimeout As Long           ''
uVerSion As Long           ''  �汾
szInfoTitle As String * 64 ''  ������ʾ�����
dwInfoFlags As Long        ''
guidItem As Long           ''  GUIDѡ��
hBalloonIcon As Long       ''  ����ͼ���Icon���
End Type
''  Shell_NotifyIconA ����dwMessageѡ����
Private Const NIM_ADD = 0         ''  ���һ����״̬��
Private Const NIM_MODIFY = &H1    ''  �޸�״̬����ͼ��(�������Ľṹ��Ϣ)
Private Const NIM_DELETE = &H2    ''  ɾ��һ�����ڵ�״̬��
Private Const NIM_SETFOCUS = &H3  ''  �����ڵ�״̬��һ������
''  NOTIFYICONDATA�ṹ��ϢFlag
Private Const NIF_MESSAGE = &H1   ''  �����ص���Ϣ(uCallbackMessage)
Private Const NIF_ICON = &H2      ''  ����ICON
Private Const NIF_TIP = &H4       ''  ����Tip��Ϣ
Private Const NIF_STATE = &H8     ''  dwStat,dwStateMask��Ч
Private Const NIF_INFO = &H10     ''  ��ʾ������ʾ��
Private Const NIF_GUID = &H20     ''  �߼�IUѡ��[Win7�����İ汾������]
Private Const NIF_SHOWTIP = &H80  ''  ������ʾTip�������Ϣ
''  ��������������ʽ��ʾ����
Enum BalloonStyle
NIIF_NONE = 0         ''  û���κη��
NIIF_INFO = &H1       ''  ��ͨ��ϢIcon��ʾ
NIIF_WARNING = &H2    ''  �����Icon��ʾ
NIIF_ERROR = &H3      ''  �����Icon��ʾ
NIIF_USER = &H4       ''  ʹ���û��Զ����Icon
NIIF_NOSOUND = &H10   ''  û������
End Enum

Dim ShellStruct As NOTIFYICONDATA

Sub CreateWindow(ByVal WindowHwnd As Long, ByVal IconHandle As Long)
ShellStruct.hwnd = WindowHwnd
ShellStruct.uFlags = NIF_ICON Or NIF_TIP
ShellStruct.hIcon = IconHandle
Shell_NotifyIconA NIM_ADD, ShellStruct
End Sub

Sub SetFocus()
Shell_NotifyIconA NIM_SETFOCUS, ShellStruct
End Sub

Sub ClearWindow()
Shell_NotifyIconA NIM_DELETE, ShellStruct
End Sub

Sub ChangeTip(ByVal TipString As String)
If Len(TipString) <= 64 Then
ShellStruct.szTip = TipString
Shell_NotifyIconA NIM_MODIFY, ShellStruct
End If
End Sub

Sub ShowTip()
ShellStruct.uFlags = NIF_SHOWTIP
Shell_NotifyIconA NIM_MODIFY, ShellStruct
End Sub
