page 51573 "Leave Roaster"
{
    Caption = 'Leave Roster';
    PageType = Card;
    SourceTable = "Leave Roaster";

    layout
    {
        area(content)
        {
            group("Leave Roaster Edit")
            {
                field("Leave Roaster No."; Rec."Leave Roaster No.")
                {
                    Applicationarea = all;
                    Editable = true;
                }
                field("Date"; Rec."Transaction Date")
                {
                    Applicationarea = all;
                    Editable = editableBool;
                    Enabled = true;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Applicationarea = all;
                    Caption = ' Staff  No.';
                    Editable = true;
                }
                field("Full Name"; Rec."Full Name")
                {
                    Applicationarea = all;
                    Editable = editableBool;
                }
                field(Comment; Rec.Comment)
                {
                    Applicationarea = all;
                    Editable = true;
                }
                field(LeaveBalance; Rec."Leave Balance")
                {
                    Caption = 'Leave Balance';
                }

            }
            group(Det)
            {
                Caption = 'Personal leave-month  suggestion';
                part(Control1000000021; "Personal leave-MonthSuggetsion")
                {
                    Applicationarea = all;
                    //SubPageLink = "Staff Code" = field("Staff No.");
                    SubPageLink = "Leave Roaster No." = field("Leave Roaster No."), "Staff Code" = field("Staff No.");

                }
            }
        }




        /*actions
        {
            area(creation)
            {
                action("Check In")
                {
                    Applicationarea = all;
                    Image = Approve;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        readMessage: Text[100];
                    begin
                        Clear(readMessage);
                        if Rec."Time In" <> 0T then Error('Already Checked in!');
                        users1.Reset;
                        users1.SetRange("User Name", UserId);
                        if users1.Find('-') then begin end;
                        Rec.TestField(Rec.Company);
                        Rec.TestField("Staff No.");
                        if Confirm('Register ' + Rec."Full Name", true) = false then Error('Registration Cancelled by ' + UserId);
                        Rec."Transaction Date" := Today;
                        Rec."Time In" := Time;
                        if users1."Full Name" = '' then
                            Rec."Signed in by" := UserId
                        else
                            Rec."Signed in by" := users1."Full Name";
                        Rec.Modify;
                        readMessage := 'Clocked in Successfully!';
                        Message(readMessage);
                    end;
                }
                action("Check Out")
                {
                    Applicationarea = all;
                    Image = Close;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ItemstoCheckOut: Record "Staff Personal Items";
                    begin

                        if Rec."Time In" = 0T then Error('Not Checked in!');
                        //TESTFIELD(Comment);
                        if Rec."Checked Out" = true then Error('Already Checked out!');

                        ItemstoCheckOut.Reset;
                        //ItemstoCheckOut.SetRange(ItemstoCheckOut."Staff Code", Rec."Visit No.");
                        ItemstoCheckOut.SetRange(ItemstoCheckOut."Staff ID", Rec."Staff No.");
                        ItemstoCheckOut.SetRange(ItemstoCheckOut.Cleared, false);
                        ItemstoCheckOut.SetFilter(ItemstoCheckOut."Item Description", '<>%1', '');
                        if ItemstoCheckOut.Find('-') then begin
                            Error('Please Check out all Peronal Items First');
                        end;

                        users1.Reset;
                        users1.SetRange("User Name", UserId);
                        if users1.Find('-') then begin end;
                        if Confirm('Check-out ' + Rec."Full Name" + '?', true) = false then Error('Check-out Cancelled by ' + UserId);
                        Rec."Time Out" := Time;
                        Rec."Checked Out" := true;
                        if users1."Full Name" = '' then
                            Rec."Signed Out By" := UserId
                        else
                            Rec."Signed Out By" := users1."Full Name";
                        Rec.Modify;
                        CurrPage.Update;
                    end;
                }
            }
        }

        trigger OnAfterGetRecord()
        begin
            if ((Rec."Checked Out" = true) or (Rec."Signed in by" <> '')) then editableBool := false else editableBool := true;
        end;

        trigger OnInit()
        begin
            editableBool := true;
        end;

        trigger OnInsertRecord(BelowxRec: Boolean): Boolean
        begin
            Rec.Comment := 'Checked in';
            Rec."Comment By" := UserId;
        end;

        trigger OnNewRecord(BelowxRec: Boolean)
        begin
            Rec.Comment := 'Checked in';
            Rec."Comment By" := UserId;
        end;
        */
    }
    actions
    {
        area(Reporting)
        {
            action("Leave Roster")
            {
                Caption = 'Leave Roster';
                ApplicationArea = All;
                Promoted = true;
                // RunObject = report "HRM-Leave Roster";
            }
        }
    }

    var
        users1: Record User;
        editableBool: Boolean;
        LeaveBalance: Integer;
        StaffCard: Record "HRM-Employee (D)";
}
