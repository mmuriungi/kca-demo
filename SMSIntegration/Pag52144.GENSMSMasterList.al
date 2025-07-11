page 52144 "GEN-SMS_Master List"
{
    ApplicationArea = All;
    Caption = 'GEN-SMS_Master List';
    PageType = List;
    SourceTable = "GEN-SMS_Master";
    UsageCategory = History;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Msg; Rec.Msg)
                {
                    ToolTip = 'Specifies the value of the Msg field.', Comment = '%';
                }
                field(Operator; Rec.Operator)
                {
                    ToolTip = 'Specifies the value of the Operator field.', Comment = '%';
                }
                field(Receiver; Rec.Receiver)
                {
                    ToolTip = 'Specifies the value of the Receiver field.', Comment = '%';
                }
                field(Sender; Rec.Sender)
                {
                    ToolTip = 'Specifies the value of the Sender field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
                field(senttime; Rec.senttime)
                {
                    ToolTip = 'Specifies the value of the senttime field.', Comment = '%';
                }
                field(sms_ID; Rec.sms_ID)
                {
                    ToolTip = 'Specifies the value of the sms_ID field.', Comment = '%';
                }
                field(sms_Status; Rec.sms_Status)
                {
                    ToolTip = 'Specifies the value of the sms_Status field.', Comment = '%';
                }
                field(sms_Type; Rec.sms_Type)
                {
                    ToolTip = 'Specifies the value of the sms_Type field.', Comment = '%';
                }
            }
        }
    }
}
