page 54366 "Premedication Drugs"
{
    PageType = ListPart;
    SourceTable = "Premendication Drugs";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Dosage; Rec.Dosage)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dosage field.';
                }
                field("No. of Days taken"; Rec."No. of Days taken")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Days taken field.';
                }
                field("Prescribed by"; Rec."Prescribed by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prescribed by field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }
}