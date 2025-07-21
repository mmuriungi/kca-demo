page 52179062 "Foundation Demo Data"
{
    PageType = Card;
    Caption = 'Foundation Demo Data Generator';
    ApplicationArea = All;
    UsageCategory = Tasks;
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Demo Data Generation';
                
                field(Info; 'Click the Generate Demo Data action to create sample foundation data including donors, donations, campaigns, grants, scholarships, events, and partnerships.')
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                    ShowCaption = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(GenerateDemoData)
            {
                ApplicationArea = All;
                Caption = 'Generate Demo Data';
                Image = CreateForm;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                
                trigger OnAction()
                var
                    FoundationDemoDataGen: Codeunit "Foundation Demo Data Generator";
                begin
                    if Confirm('This will create sample foundation data. Continue?') then
                        FoundationDemoDataGen.GenerateFoundationDemoData();
                end;
            }
            
            action(ClearDemoData)
            {
                ApplicationArea = All;
                Caption = 'Clear All Foundation Data';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    if Confirm('This will delete ALL foundation data. This action cannot be undone. Continue?') then
                        ClearFoundationData();
                end;
            }
        }
    }
    
    local procedure ClearFoundationData()
    var
        Donor: Record "Foundation Donor";
        Donation: Record "Foundation Donation";
        Campaign: Record "Foundation Campaign";
        Pledge: Record "Foundation Pledge";
        Grant: Record "Foundation Grant";
        Scholarship: Record "Foundation Scholarship";
        FoundationEvent: Record "Foundation Event";
        Partnership: Record "Foundation Partnership";
    begin
        Donation.DeleteAll();
        Pledge.DeleteAll();
        Campaign.DeleteAll();
        Grant.DeleteAll();
        Scholarship.DeleteAll();
        FoundationEvent.DeleteAll();
        Partnership.DeleteAll();
        Donor.DeleteAll();
        
        Message('All foundation data has been cleared.');
    end;
}