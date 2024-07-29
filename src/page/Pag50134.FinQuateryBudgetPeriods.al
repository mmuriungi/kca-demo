page 50134 "Fin Quatery Budget Periods"
{
    PageType = List;
    SourceTable = "FIN-Budget Quaterly Periods";
    layout
    {
        area(Content)
        {
            repeater(general)
            {

                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget Name field.';
                }
                field("Q1 Budget Start Date"; Rec."Q1 Budget Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Q1 Budget Start Date field.';
                }
                field("Q1 Budget End Date"; Rec."Q1 Budget End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Q1 Budget End Date field.';
                }
                field("Q2 Budget Start Date"; Rec."Q2 Budget Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Q2 Budget Start Date field.';
                }
                field("Q2 Budget End Date"; Rec."Q2 Budget End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Q2 Budget End Date field.';
                }
                field("Q3 Budget Start Date"; Rec."Q3 Budget Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Q3 Budget Start Date field.';
                }
                field("Q3 Budget End Date"; Rec."Q3 Budget End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Q3 Budget End Date field.';
                }
                field("Q4 Budget Start Date"; Rec."Q4 Budget Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Q4 Budget Start Date field.';
                }
                field("Q4 Budget End Date"; Rec."Q4 Budget End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Q4 Budget End Date field.';
                }
            }
        }
    }
}