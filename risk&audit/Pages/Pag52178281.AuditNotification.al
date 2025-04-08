page 52178281 "Audit Notification"
{
    PageType = Card;
    SourceTable = "Communication Header";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; "No.")
                {
                    Editable = false;
                }
                field(Type; Type)
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    MultiLine = true;
                }
                field("Created By"; "Created By")
                {
                    Editable = false;
                }
                field(Status; Status)
                {
                    Editable = false;
                }
                field("Communication Type"; "Communication Type")
                {
                    Visible = false;
                }
                group(Control13)
                {
                    ShowCaption = false;
                    Visible = (("Communication Type" = "Communication Type"::"E-Mail") OR ("Communication Type" = "Communication Type"::"E-Mail & SMS"));
                    label("Email Details:")
                    {
                        Style = Strong;
                        StyleExpr = TRUE;
                    }
                    field("E-Mail Subject"; "E-Mail Subject")
                    {
                    }
                    field("Email Message"; EmailTxt)
                    {
                        MultiLine = true;

                        trigger OnValidate()
                        begin

                            CALCFIELDS("E-Mail Body");
                            "E-Mail Body".CREATEINSTREAM(InStrm);
                            EmailBigTxt.READ(InStrm);

                            IF EmailTxt <> FORMAT(EmailBigTxt) THEN BEGIN
                                CLEAR("E-Mail Body");
                                CLEAR(EmailBigTxt);
                                EmailBigTxt.ADDTEXT(EmailTxt);
                                "E-Mail Body".CREATEOUTSTREAM(OutStrm);
                                EmailBigTxt.WRITE(OutStrm);
                            END;
                        end;
                    }
                    field(Attachment; Attachment)
                    {
                        Editable = false;

                        trigger OnAssistEdit()
                        begin
                            /*
                            IF FileManagement.CanRunDotNetOnClient THEN
                                Attachment := FileManagement.OpenFileDialog('Choose File:', '', 'All files (*.*)|*.*')
                            ELSE
                                Attachment := FileManagement.UploadFile('Choose file:', Attachment);
                            */
                        end;
                    }
                }
                group(Control14)
                {
                    ShowCaption = false;
                    Visible = (("Communication Type" = "Communication Type"::"SMS") OR ("Communication Type" = "Communication Type"::"E-Mail & SMS"));
                    field("SMS Message"; SMSTxt)
                    {
                        MultiLine = true;

                        trigger OnValidate()
                        begin

                            CALCFIELDS("SMS Text");
                            "SMS Text".CREATEINSTREAM(SMSInStrm);
                            SMSBigTxt.READ(SMSInStrm);

                            IF SMSTxt <> FORMAT(SMSBigTxt) THEN BEGIN
                                CLEAR("SMS Text");
                                CLEAR(SMSBigTxt);
                                SMSBigTxt.ADDTEXT(SMSTxt);
                                "SMS Text".CREATEOUTSTREAM(SMSOutStrm);
                                SMSBigTxt.WRITE(SMSOutStrm);
                            END;
                        end;
                    }
                }
                label("Sender:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Editable = false;
                }
                field(Sender; Sender)
                {
                }
                field("Sender Name"; "Sender Name")
                {
                }
                field("Sender Email"; "Sender Email")
                {
                }
                label("Receipient:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Notify Department"; "Notify Department")
                {
                }
                group(Control34)
                {
                    ShowCaption = false;
                    Visible = "Notify Department";
                    part(Control33; "Audit Notification Subform")
                    {
                        SubPageLink = "No." = FIELD("No.");
                    }
                }
                group(Control31)
                {
                    ShowCaption = false;
                    Visible = NOT "Notify Department";
                    field(Receipient; Receipient)
                    {
                    }
                    field("Receipient Name"; "Receipient Name")
                    {
                    }
                    field("Receipient E-Mail"; "Receipient E-Mail")
                    {
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send Notification")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AuditMgt.SendAuditNotification(Rec);
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        CALCFIELDS("E-Mail Body");
        "E-Mail Body".CREATEINSTREAM(InStrm);
        EmailBigTxt.READ(InStrm);
        EmailTxt := FORMAT(EmailBigTxt);

        CALCFIELDS("SMS Text");
        "SMS Text".CREATEINSTREAM(SMSInStrm);
        SMSBigTxt.READ(SMSInStrm);
        SMSTxt := FORMAT(SMSBigTxt);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Type := Type::"Audit Notification";
        "Communication Type" := "Communication Type"::"E-Mail";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::"Audit Notification";
        "Communication Type" := "Communication Type"::"E-Mail";
    end;

    trigger OnOpenPage()
    begin
        "Communication Type" := "Communication Type"::"E-Mail";
        IF Status = Status::Sent THEN
            CurrPage.EDITABLE(FALSE);
    end;

    var
        InStrm: InStream;
        OutStrm: OutStream;
        EmailBigTxt: BigText;
        SMSBigTxt: BigText;
        EmailTxt: Text;
        SMSTxt: Text;
        MessageTxt: Text;
        ClearNotification: Notification;
        SMSInStrm: InStream;
        SMSOutStrm: OutStream;
        HRMgt: Codeunit "HR Management";
        FileManagement: Codeunit "File Management";
        FileName: Text[250];
        AuditMgt: Codeunit "Internal Audit Management";
}

