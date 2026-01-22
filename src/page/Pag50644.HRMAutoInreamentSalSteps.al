page 50644 "HRM-Auto_Inreament Sal. Steps"
{
    Caption = 'Salary Steps Per Grade';
    DataCaptionFields = "Employee Category", "Salary Grade", Step;
    Description = 'Salary Steps Per Grade';
    PageType = List;
    SourceTable = "HRM-Auto Inreament Sal. Steps";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Step; Rec.Step)
                {
                    ApplicationArea = all;
                }
                field("Basic Salary"; Rec."Basic Salary")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

