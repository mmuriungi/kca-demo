page 51154 "Class Attendance Details Part"
{
    PageType = ListPart;
    SourceTable = "Class Attendance Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Counting; Rec.Counting)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Present; Rec.Present)
                {
                    ApplicationArea = All;
                }
                field("Total Classes"; Rec."Total Classes")
                {
                    ApplicationArea = All;
                }
                field("Present Counting"; Rec."Present Counting")
                {
                    ApplicationArea = All;
                }
                field("Absent Counting"; Rec."Absent Counting")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

