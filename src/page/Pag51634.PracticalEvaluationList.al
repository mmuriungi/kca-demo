page 51634 "Practical Evaluation List"
{
    CardPageID = "Prac Evaluation Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ACA-Semesters";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    //Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    //Editable = false;

                }
                field("Current Semester"; Rec."Current Semester")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
            }
        }
    }




    var
        ACALecturersEvaluation: Record "ACA-Lecterer Evalution";
}


