page 51245 Supervision
{
    Caption = 'Supervision2';
    PageType = List;
    SourceTable = "Supervision ";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Job Application No"; Rec."Job Application No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Application No field.', Comment = '%';
                }
                field("Supervision Category"; Rec."Supervision Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervision Category field.', Comment = '%';
                }
                field("No. Of Successfully supervised"; Rec."No. Of Successfully supervised")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Of Successfully supervised field.', Comment = '%';
                }
                field("No. Of Ongoing Supervision "; Rec."No. Of Ongoing Supervision ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Of Ongoing Supervision field.', Comment = '%';
                }


            }
        }
    }
}
