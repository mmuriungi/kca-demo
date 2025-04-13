pageextension 52178881 "Job Card Extension" extends "Job Card"
{
    actions
    {
        addafter(Attachments)
        {
            action(OpenSurveyList)
            {
                ApplicationArea = All;
                Caption = 'Survey List';
                Image = Questionaire;
                Promoted = true;
                PromotedCategory = Category7;
                RunObject = Page "Survey List";
                RunPageLink = "Project No." = field("No.");
            }
        }
    }
}
