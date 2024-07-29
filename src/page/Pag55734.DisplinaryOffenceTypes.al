page 55734 "Displinary Offence Types"
{
    PageType = List;
    SourceTable = "Displinary Offence Types";

    layout
    {
        area(content)
        {
            repeater(general)
            {

                field(Offence; Rec.Offence)
                {
                    ToolTip = 'Specifies the value of the Offence field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}