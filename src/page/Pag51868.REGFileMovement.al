page 51868 "REG-File Movement"
{
    Caption = 'REG-File Movement';
    PageType = Card;
    SourceTable = "REG-File Movement";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("File Index"; Rec."File Index")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the File Index field.';
                    ApplicationArea = All;
                }
                field("Cabinet Number"; Rec."Cabinet Number")
                {
                    ToolTip = 'Specifies the value of the Cabinet Number field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cabinet Name"; Rec."Cabinet Name")
                {
                    ToolTip = 'Specifies the value of the Cabinet Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Folio No."; Rec."Folio No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Folio No. field.';
                }

                field("Folio Number"; Rec."Folio Number")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Folio Number field.';
                    ApplicationArea = All;
                }


                field("Send To"; Rec."Send To")
                {
                    Editable = issueOut;
                    ToolTip = 'Specifies the value of the Send To field.';
                    ApplicationArea = All;
                }
                field("Receiver Name"; Rec."Receiver Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Sent"; Rec."Date Sent")
                {
                    ToolTip = 'Specifies the value of the Date Sent field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sent Time"; Rec."Sent Time")
                {
                    ToolTip = 'Specifies the value of the Sent Time field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Issued Out"; Rec."Issued Out")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bring Up field.';
                    ApplicationArea = All;
                }
                field("Bring Up Date"; Rec."Bring Up Date")
                {
                    Editable = issueOut;
                    ToolTip = 'Specifies the value of the Bring Up Date field.';
                    ApplicationArea = All;
                }
                field("Folio Returned"; Rec."Folio Returned")
                {
                    ToolTip = 'Specifies the value of the Folio Returned field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ToolTip = 'Specifies the value of the Return Date field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Return Time"; Rec."Return Time")
                {
                    ToolTip = 'Specifies the value of the Return Time field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }

            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("SendFolio")
            {
                ApplicationArea = All;
                Caption = 'Issue File ?';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                visible = issueOut;

                trigger OnAction()
                begin
                    IF CONFIRM('You are about to issue this folio, continue?', TRUE) = false THEN Error('Cancelled');
                    Rec.TestField("Send To");
                    Rec.TestField("Bring Up Date");
                    Rec.SetRange("File Index", Rec."File Index");
                    Rec."Date Sent" := Today;
                    Rec."Issued Out" := true;
                    Rec."Sent Time" := Time;
                    Message('Folio issued to ', Format(Rec."Receiver Name"));
                    CurrPage.Close();
                end;
            }

            action("Folio Return")
            {
                visible = rtrn;
                ApplicationArea = All;
                Caption = 'Folio Returned';
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    IF NOT DIALOG.CONFIRM('You are about to receive back this folio, continue?', TRUE) THEN
                        Error('Cancelled');
                    Rec.SetRange("File Index", Rec."File Index");
                    Rec."Return Date" := Today;
                    Rec."Return Time" := Time;
                    Rec."Folio Returned" := true;
                    Rec.Modify;
                    Message('File Marked as received');
                    CurrPage.Close();
                end;
            }
        }
    }
    var
        issueOut: Boolean;
        rtrn: Boolean;

    trigger OnOpenPage()
    begin
        EditForm();
    end;

    procedure EditForm()
    begin
        rtrn := false;
        issueOut := true;
        if rec."Issued Out" = true then
            issueOut := false;

        if ((Rec."Issued Out" = true) and (Rec."Folio Returned" = false)) then
            rtrn := true;
    end;

}
