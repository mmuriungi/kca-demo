page 52116 "Item Transfer List"
{
    CardPageID = "Item Transfer";
    PageType = List;
    SourceTable = "Item Transfer Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Location From Code"; Rec."Location From Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location From Code field.', Comment = '%';
                }
                field("Location To Code"; Rec."Location To Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location To Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
    }
}

