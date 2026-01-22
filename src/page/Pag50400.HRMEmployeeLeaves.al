page 50400 "HRM-Employee Leaves"
{
    PageType = Document;
    SourceTable = "HRM-Employee C";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("No."; Rec."No.")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field(Initials; Rec.Initials)
                {
                }
                field("ID Number"; Rec."ID Number")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Department Code"; Rec."Department Code")
                {
                }
                field(Position; Rec.Position)
                {
                }
                field("Contract Type"; Rec."Contract Type")
                {
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                }
            }
            part(Control1000000028; "HRM-Employee Leave Assignment")
            {
                SubPageLink = "Employee No" = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*IF CONFIRM('Do really want to post the Allocation?') THEN BEGIN
                    EmpLeave.RESET;
                    EmpLeave.SETRANGE(EmpLeave."Employee No","No.");
                    EmpLeave.SETRANGE(EmpLeave.Posted,FALSE);
                    IF EmpLeave.FIND('-') THEN BEGIN
                    REPEAT
                    LeaveEntry.INIT;
                    LeaveEntry."Document No":=EmpLeave."Employee No";
                    LeaveEntry."To Date":=EmpLeave."Leave Code";
                    LeaveEntry."Duration Units":=TODAY;
                    LeaveEntry.Duration:=EmpLeave.Balance;
                    LeaveEntry."Cost Of Training":=LeaveEntry."Cost Of Training"::"1";
                    LeaveEntry.INSERT(TRUE);
                    EmpLeave.Posted:=TRUE;
                    EmpLeave."Posting Date":=TODAY;
                    EmpLeave.UserID:=USERID;
                    EmpLeave.MODIFY;
                    UNTIL EmpLeave.NEXT=0;
                    END;
                    END;
                                        */

                end;
            }
        }
    }

    var
        LeaveEntry: Record "HRM-Back To Office Form";
        EmpLeave: Record "HRM-Emp. Leaves";
}

