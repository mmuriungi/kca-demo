page 50117 "Audit Communication"
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
                }
                field("Communication Type"; "Communication Type")
                {
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
                    field("Sender Email"; "Sender Email")
                    {
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
                    field("Receipient E-Mail"; "Receipient E-Mail")
                    {
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
        }
    }

    actions
    {
        area(processing)
        {
            action("Report Risk")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AuditMgt.SendRiskCommunication(Rec);
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
        Type := Type::Audit;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::Audit;
    end;

    trigger OnOpenPage()
    begin
        IF Sent THEN
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

