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
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    MultiLine = true;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                }
                field("Communication Type"; Rec."Communication Type")
                {
                }
                group(Control13)
                {
                    ShowCaption = false;
                    Visible = ((Rec."Communication Type" = Rec."Communication Type"::"E-Mail") OR (Rec."Communication Type" = Rec."Communication Type"::"E-Mail & SMS"));
                    label("Email Details:")
                    {
                        Style = Strong;
                        StyleExpr = TRUE;
                    }
                    field("Sender Email"; Rec."Sender Email")
                    {
                    }
                    field("E-Mail Subject"; Rec."E-Mail Subject")
                    {
                    }
                    field("Email Message"; Rec."E-Mail Body")
                    {
                        MultiLine = true;

                        trigger OnValidate()
                        begin


                        end;
                    }
                    field("Receipient E-Mail"; Rec."Receipient E-Mail")
                    {
                    }
                }
                group(Control14)
                {
                    ShowCaption = false;
                    Visible = ((Rec."Communication Type" = Rec."Communication Type"::"SMS") OR (Rec."Communication Type" = Rec."Communication Type"::"E-Mail & SMS"));
                    field("SMS Message"; Rec."SMS Text")
                    {
                        MultiLine = true;

                        trigger OnValidate()
                        begin

                        end;
                    }
                }
                field(Attachment; Rec.Attachment)
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

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Audit;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Audit;
    end;

    trigger OnOpenPage()
    begin
        IF Rec.Sent THEN
            CurrPage.EDITABLE(FALSE);
    end;

    var
        InStrm: InStream;
        OutStrm: OutStream;        
        ClearNotification: Notification;
        SMSInStrm: InStream;
        SMSOutStrm: OutStream;
        FileManagement: Codeunit "File Management";
        FileName: Text[250];
        AuditMgt: Codeunit "Internal Audit Management";
}

