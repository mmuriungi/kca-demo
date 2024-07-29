page 50939 "HRM-Leave Application List"
{
    Editable = false;
    PageType = List;
    SourceTable = "HRM-Leave Requisition";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Campus Code"; Rec."Campus Code")
                {
                }
                field("Department Code"; Rec."Department Code")
                {
                }
                field("Applied Days"; Rec."Applied Days")
                {
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Purpose; Rec.Purpose)
                {
                }
                field("Leave Type"; Rec."Leave Type")
                {
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Posted By"; Rec."Posted By")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Process Leave Allowance"; Rec."Process Leave Allowance")
                {
                }
                field("Availlable Days"; Rec."Availlable Days")
                {
                }
                field("Return Date"; Rec."Return Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

