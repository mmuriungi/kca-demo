page 51946 "Displinary Committe InvstF"
{
    PageType = List;
    SourceTable = "Displinary Committe InvstF";
    layout
    {
        area(Content)
        {
            repeater(general)
            {

                field("Case No"; Rec."Case No")
                {
                    ToolTip = 'Specifies the value of the Case No field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Investigation Commitee"; Rec."Investigation Commitee")
                {
                    ToolTip = 'Specifies the value of the Investigation Commitee field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Charge; Rec.Charge)
                {
                    ToolTip = 'Specifies the value of the Charge field.';
                    ApplicationArea = All;
                }
                field("start Date"; Rec."start Date")
                {
                    ToolTip = 'Specifies the value of the start Date field.';
                    ApplicationArea = All;
                }
                field(Findings; Rec.Findings)
                {
                    ToolTip = 'Specifies the value of the Findings field.';
                    ApplicationArea = All;
                }
                field(Conclusion; Rec.Conclusion)
                {
                    ToolTip = 'Specifies the value of the Conclusion field.';
                    ApplicationArea = All;
                }
                field("Investigation Closed"; Rec."Investigation Closed")
                {
                    ToolTip = 'Specifies the value of the Investigation Closed field.';
                    ApplicationArea = All;
                }
                field("Officer Incharge"; Rec."Officer Incharge")
                {
                    ToolTip = 'Specifies the value of the Officer Incharge field.';
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