pageextension 52178739 "Tendering Process Role Center" extends "Purchasing Agent Role Center"
{
    actions
    {
        addbefore("Posted Documents")
        {


            group(Tender)
            {
                Caption = 'Tendering Process';
                Image = LotInfo;

                group(TenderSetup)
                {

                    Caption = 'Setups';
                    action("No.series")
                    {
                        Caption = 'Tendering Series';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Tender Series Setup";
                    }

                    action(PreliminarySetup)
                    {
                        Caption = 'Preliminary Setups';
                        ApplicationArea = basic, suite;
                        RunObject = Page "Tender Preliminary Reqs Setup";
                    }
                    action(TechnicalSetup)
                    {
                        Caption = 'Technical Setups';
                        ApplicationArea = basic, suite;
                        RunObject = Page "Tender Technical Eval Setup";
                    }
                    action(DemoSetup)
                    {
                        Caption = 'Demonstration Setups';
                        ApplicationArea = basic, suite;
                        RunObject = Page "Tender Demo Setup";
                    }
                    action(financialSetup)
                    {
                        Caption = 'Financial Setups';
                        ApplicationArea = All;
                        RunObject = Page "Tender Financial Setups";
                    }
                }

                action("Tendering")
                {
                    Caption = 'Tender Applicants';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Applicants List";
                }
                action(Tenders)
                {
                    Caption = 'Tenders';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender List";
                }
                action(SubmittedTenders)
                {
                    Caption = 'Submitted Tenders';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Submission List View";
                }
                action(PreliminaryQualifiers)
                {
                    Caption = 'Preliminary Qualifiers';
                    ApplicationArea = basic, suite;
                    //RunObject = Page "Tender Preliminary QualfyList";
                    RunObject = Page "Tender Prelim QualifyiedL";
                }
                action(TechnicalQualifiers)
                {
                    Caption = 'Technical Qualifiers';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Technical QualifyiedL";
                    //RunObject = Page "Tender Technical QualifiedList";

                }
                action(DemoQualifiers)
                {
                    Caption = 'Demonstration Qualifiers';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Demo QualifyiedL";
                    //RunObject = Page "Tender Demo QualifiedList";
                }
                action(FinancialQualifiers)
                {
                    Caption = 'Financial Qualifiers';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Fin QualifyiedL";
                }
                action(Award)
                {
                    Caption = 'Awarded';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Awarded List";
                }

            }
            group(TenderD)
            {
                Caption = 'Failed Bids';
                action(PQTenders)
                {
                    Caption = 'Preliminary Disqualified';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Disq Preliminary List";
                }
                action(TQTenders)
                {
                    Caption = 'Technical Disqualified';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Disq Technical List";
                }
                action(DQTenders)
                {
                    Caption = 'Demo Disqualified';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Disq Demo List";
                }
                action(FQTenders)
                {
                    Caption = 'Financial Disqualified';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Disq Financial List";
                }

            }

        }

    }


}
