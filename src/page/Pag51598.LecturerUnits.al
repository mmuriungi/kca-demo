page 51598 "Lecturer Units"
{
    Caption = 'Lecturer Units';
    Editable = false;
    PageType = ListPart;
    SourceTable = "ACA-Lecturers Units";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
