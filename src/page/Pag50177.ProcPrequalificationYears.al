page 50177 "Proc-Prequalification Years"
{
    Caption = 'Proc-Prequalification Years';
    PageType = List;
    SourceTable = "Prequalification Years";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Preq Years"; Rec."Preq Years")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preq Years field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Preq Categories"; Rec."Preq Categories")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preq Categories field.';
                }
                field("Preq Date List"; Rec."Preq Date List")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preq Date List field.';
                }
            }
        }
    }
}
