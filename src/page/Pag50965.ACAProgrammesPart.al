/// <summary>
/// Page ACA-Programmes List (ID 68757).
/// </summary>
page 50965 "ACA-Programmes Part"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = ListPart;
    SourceTable = "ACA-Programme";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Time Table"; Rec."Time Table")
                {
                    ApplicationArea = All;
                }
                field("Total Income"; Rec."Total Income")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Exam Category"; Rec."Exam Category")
                {
                    ApplicationArea = All;
                }
                field("School Code"; Rec."School Code")
                {
                    ApplicationArea = All;
                }
                field("Student Registered"; Rec."Student Registered")
                {
                    ApplicationArea = All;
                }
                field("Male Count"; Rec."Male Count")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Female Count"; Rec."Female Count")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Not Classified"; Rec."Not Classified")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }


}

