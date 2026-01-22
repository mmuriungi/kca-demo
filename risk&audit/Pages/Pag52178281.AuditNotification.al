page 50119 "Audit Notification"
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
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Communication Type"; Rec."Communication Type")
                {
                    ApplicationArea = All;
                    Visible = false;
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
                    field("E-Mail Subject"; Rec."E-Mail Subject")
                    {
                        ApplicationArea = All;
                    }
                    field("Email Message"; rec."E-Mail Body")
                    {
                        ApplicationArea = All;
                        MultiLine = true;

                        trigger OnValidate()
                        begin


                        end;
                    }
                    field(Attachment; Rec.Attachment)
                    {
                        ApplicationArea = All;
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
                    Visible = ((Rec."Communication Type" = Rec."Communication Type"::"SMS") OR (Rec."Communication Type" = Rec."Communication Type"::"E-Mail & SMS"));
                    field("SMS Message"; rec."SMS Text")
                    {
                        ApplicationArea = All;
                        MultiLine = true;

                        trigger OnValidate()
                        begin

                        end;
                    }
                }
                label("Sender:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Sender; Rec.Sender)
                {
                    ApplicationArea = All;
                }
                field("Sender Name"; Rec."Sender Name")
                {
                    ApplicationArea = All;
                }
                field("Sender Email"; Rec."Sender Email")
                {
                    ApplicationArea = All;
                }
                label("Receipient:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Notify Department"; Rec."Notify Department")
                {
                    ApplicationArea = All;
                }
                group(Control34)
                {
                    ShowCaption = false;
                    Visible = Rec."Notify Department";
                    part(Control33; "Audit Notification Subform")
                    {
                        ApplicationArea = All;
                        SubPageLink = "No." = FIELD("No.");
                    }
                }
                group(Control31)
                {
                    ShowCaption = false;
                    Visible = NOT Rec."Notify Department";
                    field(Receipient; Rec.Receipient)
                    {
                        ApplicationArea = All;
                    }
                    field("Receipient Name"; Rec."Receipient Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Receipient E-Mail"; Rec."Receipient E-Mail")
                    {
                        ApplicationArea = All;
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
                ApplicationArea = All;
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
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Audit Notification";
        Rec."Communication Type" := Rec."Communication Type"::"E-Mail";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Audit Notification";
        Rec."Communication Type" := Rec."Communication Type"::"E-Mail";
    end;

    trigger OnOpenPage()
    begin
        Rec."Communication Type" := Rec."Communication Type"::"E-Mail";
        IF Rec.Status = Rec.Status::Sent THEN
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
        FileManagement: Codeunit "File Management";
        FileName: Text[250];
        AuditMgt: Codeunit "Internal Audit Management";
}

