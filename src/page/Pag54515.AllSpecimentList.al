page 54515 AllSpecimentList
{
    Caption = 'AllSpecimentList';
    PageType = List;
    SourceTable = AllSpecimentList;

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
                field("Lab Test"; Rec."Lab Test")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lab Test field.', Comment = '%';
                }
                field("Specimen Name"; Rec."Specimen Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Specimen Name field.', Comment = '%';
                }
                field("Lab Test Description"; Rec."Lab Test Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lab Test Description field.', Comment = '%';
                }
                field(Result; Rec.Result)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Result field.', Comment = '%';
                }
                field(unit; Rec.unit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the unit field.', Comment = '%';
                }
                field("Maximum Value"; Rec."Maximum Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Value field.', Comment = '%';
                }
                field(Flag; Rec.Flag)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Flag field.', Comment = '%';
                }
                field("Minimum Value"; Rec."Minimum Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Value field.', Comment = '%';
                }

            }
        }
    }
}
