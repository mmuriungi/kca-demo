page 54503 "Prac Evaluation Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "ACA-Semesters";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    Editable = true;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
            part("Evaluation Questions"; "Practical Eval Questions")
            {
                SubPageLink = Semester = FIELD(Code);
                ApplicationArea = All;
            }
        }
    }
}
