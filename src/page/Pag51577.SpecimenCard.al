page 51577 "Specimen Card"
{
    Caption = 'Specimen Card';
    PageType = Card;

    SourceTable = "Speciment  list";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("specimen code"; Rec."specimen code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the specimen code field.', Comment = '%';
                }
                field("Speciment Description"; Rec."Specimen Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Speciment Description field.', Comment = '%';
                }
                field("Lab Test"; Rec."Lab Test")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Speciment Description field.', Comment = '%';
                }
                field("Lab Test Description"; Rec."Lab Test Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lab Test Description field.', Comment = '%';
                }
                field(Result; Rec.Result)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Speciment Description field.', Comment = '%';
                }
                field(unit; Rec.unit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Speciment Description field.', Comment = '%';
                }
                field("Normal Range"; Rec."Normal Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Speciment Description field.', Comment = '%';
                }
                field(Flag; Rec.Flag)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Flag field.', Comment = '%';
                }
            }
        }
    }
}

