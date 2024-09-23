page 52059 "Headline RC Postgrad Director"
{
    PageType = HeadlinePart;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                Visible = UserGreetingVisible;
                field(GreetingText; RCHeadlinesPageCommon.GetGreetingText())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Greeting headline';
                    Editable = false;
                }
            }
            group(Control2)
            {
                ShowCaption = false;
                Visible = PendingApplicationsVisible;
                field(PendingApplications; PendingApplicationsText)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Applications';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Supervisor Applications", SupervisorApplication);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        LoadTopNewsArticle();
        SetGreetingText();
        ShowPendingApplications();
    end;

    var
        GreetingText: Text;
        PendingApplicationsText: Text;
        PendingApplicationsVisible: Boolean;
        SupervisorApplication: Record "Postgrad Supervisor Applic.";
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";

        DefaultFieldsVisible: Boolean;
        UserGreetingVisible: Boolean;

    local procedure LoadTopNewsArticle()
    begin
        // Load top news article logic here
    end;

    local procedure SetGreetingText()
    var
        headline: page "Headline RC Accountant";
    begin
        DefaultFieldsVisible := RCHeadlinesPageCommon.AreDefaultFieldsVisible();
        UserGreetingVisible := RCHeadlinesPageCommon.IsUserGreetingVisible();
    end;

    local procedure ShowPendingApplications()
    begin
        SupervisorApplication.Reset();
        SupervisorApplication.SetRange(Status, SupervisorApplication.Status::Pending);
        if SupervisorApplication.Count <> 0 then begin
            PendingApplicationsText := StrSubstNo('You have %1 pending supervisor applications', SupervisorApplication.Count);
            PendingApplicationsVisible := true;
        end else
            PendingApplicationsVisible := false;
    end;
}
