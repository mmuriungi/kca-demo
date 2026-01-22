page 52042 "Headline RC Contract Mgmt"
{
    PageType = HeadlinePart;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(GreetingHeadline)
            {
                ShowCaption = false;
                Visible = TRUE;
                field(Greeting; GreetingText)
                {
                    ApplicationArea = All;
                    Caption = 'Greeting';
                    Editable = false;
                }
            }
            group(ContractHeadline)
            {
                ShowCaption = false;
                Visible = TRUE;
                field(ContractInfo; ContractInfoText)
                {
                    ApplicationArea = All;
                    Caption = 'Contract Info';
                    Editable = false;
                }
            }
        }
    }

    var
        GreetingText: Text;
        ContractInfoText: Text;

    trigger OnOpenPage()
    begin
        SetGreetingText();
        SetContractInfoText();
    end;

    local procedure SetGreetingText()
    var
        UserSetup: Record "User";
        UserName: Text[50];
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User Name", UserId);
        if UserSetup.FindFirst() then
            UserName := UserSetup."Full Name"
        else
            UserName := UserId;

        GreetingText := 'Hello ' + UserName + ', welcome to Contract Management!';
    end;

    local procedure SetContractInfoText()
    var
        Contract: Record "Project Header";
        ActiveContracts: Integer;
        ExpiringContracts: Integer;
    begin
        Contract.SetRange(Status, Contract.Status::Verified);
        ActiveContracts := Contract.Count;

        Contract.SetRange("Actual End Date", WorkDate(), CalcDate('<+30D>', WorkDate()));
        ExpiringContracts := Contract.Count;

        ContractInfoText := StrSubstNo('You have %1 active contracts. %2 contracts are expiring in the next 30 days.', ActiveContracts, ExpiringContracts);
    end;
}