page 52102 "Program Prerequisite"
{
    Caption = 'Program Prerequisite';
    PageType = ListPart;
    SourceTable = "Prerequsite Requirements";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Application No"; Rec."Application No")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Application No field.', Comment = '%';
                }
                field("Prerequisite Code"; Rec."Prerequisite Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prerequisite Code field.', Comment = '%';
                }
                field("Prerequisite Score"; Rec."Prerequisite Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prerequisite Score field.', Comment = '%';
                }
                field("Work Experience"; Rec."Work Experience")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Work Experience field.', Comment = '%';
                }
            }
        }
    }
}
