page 51234 "HR Leave Planner Lines Drill"
{
    PageType = List;
    SourceTable = "HR Leave Planner Drill";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application Code"; Rec."Application Code")
                {
                    Editable = false;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                }
                field("Days Applied"; Rec."Days Applied")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Return Date"; Rec."Return Date")
                {
                }
                field("Applicant Comments"; Rec."Applicant Comments")
                {
                }
                field(Reliever; Rec.Reliever)
                {
                }
                field("Reliever Name"; Rec."Reliever Name")
                {
                }
                field(Month; Rec.Month)
                {
                    Editable = false;
                }
                field(Year; Rec.Year)
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Employee No" := Rec.GETFILTER("Employee No");
        IF EVALUATE(Rec.Month, Rec.GETFILTER(Month)) THEN
            Rec.Month := Rec.Month;
        IF EVALUATE(Rec.Year, Rec.GETFILTER(Year)) THEN
            Rec.Year := Rec.Year;

        COMMIT;
        Rec."User ID" := USERID;
    end;

    trigger OnOpenPage()
    begin
        Rec.SETFILTER("User ID", USERID)
    end;
}

