page 52077 "Medical Dependants"
{
    ApplicationArea = All;
    Caption = 'Medical Dependants';
    PageType = List;
    SourceTable = "HRM-Medical Dependants";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Names; Rec.Names)
                {
                    ToolTip = 'Specifies the value of the Names field.', Comment = '%';
                }
                field(Relationship; Rec.Relationship)
                {
                    ToolTip = 'Specifies the value of the Relationship field.', Comment = '%';
                }
                field(Dependant; Rec.Dependant)
                {
                    ToolTip = 'Specifies the value of the Dependant field.', Comment = '%';
                }
                field("Pricipal Member no"; Rec."Pricipal Member no")
                {
                    ToolTip = 'Specifies the value of the Pricipal Member no field.', Comment = '%';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Specifies the value of the Date of Birth field.', Comment = '%';
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ToolTip = 'Specifies the value of the Telephone No field.', Comment = '%';
                }
            }
        }
    }
}
