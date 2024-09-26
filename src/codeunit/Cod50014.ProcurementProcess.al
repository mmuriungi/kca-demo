codeunit 50014 "Procurement Process"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var

        Commiteeheader: Record "Proc-Committee Appointment H";
        Commitee: Record "Proc-Committee Members";
        BidderNo: Code[50];
        purheader: Record "Purchase Header";
        prlines: Record "Purchase Line";
        Usersetup: Record "User Setup";
        ven: Record Vendor;
        purpay: Record "Purchases & Payables Setup";
        noseries: Codeunit NoSeriesManagement;
        qlines: Record "Purchase Line";
        sno: Integer;
        purQuotes: Record "Purchase Header";
        Thead1: Record "Purchase Header";
        prelQ1: Record "Proc-Preliminary Qualif";
        techQ1: Record "Proc-Technical Qualif";
        DemoQ1: Record "Proc-Demo Qualif";
        FinQ1: record "Proc-Financial Qualif";
        prelQ2: Record "Proc-Preliminary Qualif.Quote";
        techQ2: Record "Proc-Technical Qualif.Quote";
        DemoQ2: Record "Proc-Demo Qualif.Quote";
        FinQ2: record "Proc-Financial Qualif.Quote";
        purHead: Record "Purchase Header";
        Tsubmission: record "Tender Submission Header";
        phead: Record "Purchase Header";
        rfq: Record "PROC-Purchase Quote Header1";
        mem: Record "Proc-Committee Membership";
        Rmet: Integer;
        Rnmet: Integer;
        eval: Record "Proc Evaluation Report";
        confrm: Record "Proc-Confirm Recommended";
        committe: Record "Proc-Committee Membership";
        Pheader: Record "Purchase Header";

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeCheckBuyFromVendorNo, '', false, false)]
    local procedure skipOnBeforeCheckBuyFromVendorNo(PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Quote then begin
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeGetVPGInvRoundAcc, '', false, false)]
    local procedure skipOnBeforeGetVPGInvRoundAcc(PurchHeader: Record "Purchase Header"; Vendor: Record Vendor; var AccountNo: Code[20]; var IsHandled: Boolean)
    begin
        if PurchHeader."Document Type" = PurchHeader."Document Type"::Quote then begin
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeValidateNo, '', false, false)]
    local procedure OnBeforeValidateNo(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        if PurchaseLine."Document Type" = PurchaseLine."Document Type"::Quote then begin
            IsHandled := true;
            PurchaseLine.validateRequisitionLine();
        end;
    end;

    procedure fnGetAccounntNames(AccType: Enum "Purchase Line Type"; AccNo: Code[20]): Text
    var
        GLAcc: Record "G/L Account";
        Vendor: Record Vendor;
        Customer: Record Customer;
        Item: Record Item;
        BankAcc: Record "Bank Account";
        Emp: Record Employee;
        FA: Record "Fixed Asset";
    begin
        case AccType of
            AccType::"G/L Account":
                begin
                    GLAcc.Get(AccNo);
                    exit(GLAcc.Name);
                end;
            AccType::Item:
                begin
                    Item.Get(AccNo);
                    exit(Item.Description);
                end;
            AccType::"Fixed Asset":
                begin
                    FA.Get(AccNo);
                    exit(FA.Description);
                end;
            AccType::"Charge (Item)":
                begin
                    item.Get(AccNo);
                    exit(item.Description);
                end;
        end;
    end;
    //Re-Evaluate
    procedure RedoEvaluation(QuoteNo: Code[50])
    var
        phead: Record "Purchase Header";
        rfq: Record "PROC-Purchase Quote Header1";
        mem: Record "Proc-Committee Membership";
        BidderNo: Code[50];
    begin
        rfq.Reset();
        rfq.SetRange("No.", QuoteNo);
        rfq.SetRange("Has Evaluation", rfq."Has Evaluation"::Yes);
        if rfq.Find('-') then begin
            phead.Reset();
            phead.SetRange("Request for Quote No.", QuoteNo);
            if phead.Find('-') then begin
                repeat
                    phead."Quote Status" := phead."Quote Status"::Submitted;
                    phead.Modify();
                until phead.Next() = 0;
            end;
            prelQ2.Reset();
            prelQ2.SetRange("No.", QuoteNo);
            if prelQ2.Find('-') then begin
                repeat
                    prelQ2.DeleteAll();
                until prelQ2.Next() = 0;
            end;
            techQ2.Reset();
            techQ2.SetRange("No.", QuoteNo);
            if techQ2.Find('-') then begin
                repeat
                    techQ2.DeleteAll();
                until techQ2.Next() = 0;
            end;
            DemoQ2.Reset();
            DemoQ2.SetRange("No.", QuoteNo);
            if DemoQ2.Find('-') then begin
                repeat
                    DemoQ2.DeleteAll();
                until DemoQ2.Next() = 0;
            end;
        end;
        EvaluationSetups(QuoteNo);
    end;

    //Evaluation parameters
    procedure EvaluationSetups(QuoteNo: Code[50])
    var
        phead: Record "Purchase Header";
        rfq: Record "PROC-Purchase Quote Header1";
        mem: Record "Proc-Committee Membership";
        Commitee: Record "Proc-Committee Members";
        BidderNo: Code[50];
    begin
        rfq.Reset();
        rfq.SetRange("No.", QuoteNo);
        rfq.SetRange("Has Evaluation", rfq."Has Evaluation"::Yes);
        if rfq.Find('-') then begin
            Commiteeheader.Reset();
            Commiteeheader.SetRange("Tender/Quote No", QuoteNo);
            if Commiteeheader.Find('-') then begin
                Commitee.Reset();
                Commitee.SetRange("Ref No", Commiteeheader."Ref No");
                Commitee.SetRange(Role, Commitee.Role::Secretary);
                if Commitee.Find('-') then begin
                    mem.Reset();
                    mem.SetRange("No.", QuoteNo);
                    mem.SetRange("Staff No.", Commitee."Member No");
                    if mem.Find('-') then begin
                        Usersetup.Reset();
                        Usersetup.SetRange("Employee No.", mem."Staff No.");
                        if Usersetup.Find('-') then begin
                            if Usersetup."User ID" <> UserId then Error('%1 you are not the secretary', mem.Name);
                        end;
                    end;
                end /* else
                    Error('The evaluation committee has no secretary'); */
            end;

            mem.Reset();
            mem.SetRange("No.", QuoteNo);
            mem.SetRange("Committee Type", mem."Committee Type"::"Evaluation Committee");
            mem.SetFilter("Entry No.", '<>%1', 0);
            if mem.Find('-') then begin
                repeat
                    phead.Reset();
                    phead.SetRange("Request for Quote No.", QuoteNo);
                    if phead.Find('-') then begin
                        repeat
                            //Preliminary
                            prelQ1.Reset();
                            prelQ1.SetRange("No.", QuoteNo);
                            if prelQ1.Find('-') then begin
                                repeat
                                    BidderNo := phead."No.";
                                    prelQ2.Reset();
                                    prelQ2.SetRange("Entry No.", prelQ1."Entry No.");
                                    prelQ2.SetRange("No.", prelQ1."No.");
                                    prelQ2.SetRange("Quote No.", BidderNo);
                                    prelQ2.SetRange("Staff No", mem."Staff No.");
                                    if not prelQ2.Find('-') then begin
                                        prelQ2.Init();
                                        prelQ2."Entry No." := prelQ1."Entry No.";
                                        prelQ2.Mandatory := prelQ1.Mandatory;
                                        prelQ2."No." := prelQ1."No.";
                                        prelQ2."Quote No." := BidderNo;
                                        prelQ2.Description := prelQ1.Description;
                                        prelQ2."Staff No" := mem."Staff No.";
                                        prelQ2."Staff Name" := mem.Name;
                                        prelQ2."Quote Status" := prelQ2."Quote Status"::Preliminary;
                                        prelQ2.Insert();
                                    end;
                                until prelQ1.Next() = 0;
                            end;
                            //Technical
                            techQ1.Reset();
                            techQ1.SetRange("No.", QuoteNo);
                            if techQ1.Find('-') then begin
                                repeat
                                    BidderNo := phead."No.";
                                    techQ2.Reset();
                                    techQ2.SetRange("Entry No.", techQ1."Entry No.");
                                    techQ2.SetRange("No.", techQ1."No.");
                                    techQ2.SetRange("Quote No.", BidderNo);
                                    techQ2.SetRange("Staff No", mem."Staff No.");
                                    if not techQ2.Find('-') then begin
                                        techQ2.Init();
                                        techQ2."Entry No." := techQ1."Entry No.";
                                        techQ2."No." := techQ1."No.";
                                        techQ2."Quote No." := BidderNo;
                                        techQ2.Description := techQ1.Description;
                                        techQ2."Staff No" := mem."Staff No.";
                                        techQ2."Staff Name" := mem.Name;
                                        techQ2."Maximum Score" := techQ1."Maximum Score";
                                        techQ2."Satisfactory Score" := techQ1."Satisfactory Score";
                                        techQ2."Quote Status" := techQ2."Quote Status"::Preliminary;
                                        techQ2.Insert();
                                    end;
                                until techQ1.Next() = 0;
                            end;
                            //Demo
                            DemoQ1.Reset();
                            DemoQ1.SetRange("No.", QuoteNo);
                            if DemoQ1.Find('-') then begin
                                repeat
                                    BidderNo := phead."No.";
                                    DemoQ2.Reset();
                                    DemoQ2.SetRange("Entry No.", DemoQ1."Entry No.");
                                    DemoQ2.SetRange("No.", DemoQ1."No.");
                                    DemoQ2.SetRange("Quote No.", BidderNo);
                                    DemoQ2.SetRange("Staff No", mem."Staff No.");
                                    if not DemoQ2.Find('-') then begin
                                        DemoQ2.Init();
                                        DemoQ2."Entry No." := DemoQ1."Entry No.";
                                        DemoQ2."No." := DemoQ1."No.";
                                        DemoQ2."Quote No." := BidderNo;
                                        DemoQ2.Description := DemoQ1.Description;
                                        DemoQ2."Staff No" := mem."Staff No.";
                                        DemoQ2."Staff Name" := mem.Name;
                                        DemoQ2."Maximum Score" := DemoQ1."Maximum Score";
                                        DemoQ2."Satisfactory Score" := DemoQ1."Satisfactory Score";
                                        DemoQ2."Quote Status" := DemoQ2."Quote Status"::Preliminary;
                                        DemoQ2.Insert();

                                    end;

                                until DemoQ1.Next() = 0;
                            end;

                        until phead.Next() = 0;
                    end;


                until mem.Next() = 0;
            end;

            Message('Complete');
        end;

    end;
    //Preliminary Evaluation
    procedure PreliminaryEvaluation(TenderNo: Code[50])
    begin
        rfq.Reset();
        rfq.SetRange("No.", TenderNo);
        rfq.SetRange("Has Evaluation", rfq."Has Evaluation"::Yes);
        rfq.SetRange("Preliminary Evaluation", rfq."Preliminary Evaluation"::Yes);
        if rfq.find('-') then begin
            Commiteeheader.Reset();
            Commiteeheader.SetRange("Tender/Quote No", TenderNo);
            if Commiteeheader.Find('-') then begin
                Commitee.Reset();
                Commitee.SetRange("Ref No", Commiteeheader."Ref No");
                Commitee.SetRange(Role, Commitee.Role::Secretary);
                if Commitee.Find('-') then begin
                    mem.Reset();
                    mem.SetRange("No.", TenderNo);
                    mem.SetRange("Staff No.", Commitee."Member No");
                    if mem.Find('-') then begin
                        Usersetup.Reset();
                        Usersetup.SetRange("Employee No.", mem."Staff No.");
                        if Usersetup.Find('-') then begin
                            if Usersetup."User ID" <> UserId then Error('%1 you are not the secretary', mem.Name);
                        end;
                    end;
                end /* else
                    Error('The evaluation committee has no secretary'); */
            end;

            purHead.Reset();
            purHead.SetRange("Request for Quote No.", TenderNo);
            purHead.SetRange("Quote Status", purHead."Quote Status"::Submitted);
            if purHead.find('-') then begin
                repeat
                    prelQ2.Reset();
                    prelQ2.SetRange("No.", TenderNo);
                    prelQ2.SetRange("Quote No.", purHead."No.");
                    prelQ2.Setrange(Evaluated, false);
                    if prelQ2.Find('-') then begin
                        Error('%1%2', 'Some Committee members have not done preliminary evaluation, e.g ', prelQ2."Staff Name");
                    end;
                    prelQ2.Reset();
                    prelQ2.SetRange("No.", TenderNo);
                    prelQ2.SetRange("Quote No.", purHead."No.");
                    prelQ2.SetRange("Entry No.", prelQ2."Entry No.");
                    prelQ2.Setfilter(Scored, '=%1', prelQ2.Scored::"Requirement Met");
                    if prelQ2.Find('-') then begin
                        prelQ2.CalcFields(Evaluators);
                        Rmet := prelQ2.Count;
                        if (Rmet <> prelQ2.Evaluators) then Error('Scores for %1 are not same for all evaluators', prelQ2."Quote No.");
                    end;
                    prelQ2.Reset();
                    prelQ2.SetRange("No.", TenderNo);
                    prelQ2.SetRange("Quote No.", purHead."No.");
                    prelQ2.SetRange("Entry No.", prelQ2."Entry No.");
                    prelQ2.Setfilter(Scored, '=%1', prelQ2.Scored::"Requirement Not Met");
                    if prelQ2.Find('-') then begin
                        prelQ2.CalcFields(Evaluators);
                        Rnmet := prelQ2.Count;
                        if (Rnmet <> prelQ2.Evaluators) then Error('Scores for %1 are not same for all evaluators', prelQ2."Quote No.");
                    end;
                    prelQ2.Reset();
                    prelQ2.SetRange("No.", TenderNo);
                    prelQ2.SetRange("Quote No.", purHead."No.");
                    if prelQ2.Find('-') then begin
                        repeat
                            if prelQ2.Scored = prelQ2.Scored::"Requirement Not Met" then begin
                                purHead."Quote Status" := purHead."Quote Status"::"Prelim DisQualif";
                                prelQ2."Quote Status" := prelQ2."Quote Status"::Failed;
                                prelQ2.Modify();
                                purHead.Modify();
                            end
                            else
                                if prelQ2.Scored = prelQ2.Scored::"Requirement Met" then begin
                                    purHead."Quote Status" := purHead."Quote Status"::"Prelim qualif";
                                    prelQ2."Quote Status" := prelQ2."Quote Status"::Technical;
                                    prelQ2.Modify();
                                    purHead.Modify();
                                    techQ2.Reset();
                                    techQ2.SetRange("No.", TenderNo);
                                    techQ2.SetRange("Quote No.", prelQ2."Quote No.");
                                    if techQ2.Find('-') then begin
                                        repeat
                                            techQ2."Quote Status" := techQ2."Quote Status"::Technical;
                                            techQ2.Modify();
                                        until techQ2.Next() = 0;
                                    end;
                                end;
                        until prelQ2.Next() = 0;
                    end;
                until purHead.Next() = 0;

            end;
            rfq.Reset();
            rfq.SetRange("No.", TenderNo);
            rfq.SetRange("Has Evaluation", rfq."Has Evaluation"::Yes);
            rfq.SetRange("Technical Evaluation", rfq."Preliminary Evaluation"::No);
            if rfq.find('-') then begin
                purHead.Reset();
                purHead.SetRange("Request for Quote No.", TenderNo);
                //purHead.SetRange("Quote No.", purHead."No.");
                purHead.SetRange("Quote Status", purHead."Quote Status"::Submitted);
                if purHead.find('-') then begin
                    repeat
                        purHead."Quote Status" := purHead."Quote Status"::"Prelim Qualif";
                        purHead.Modify();
                        prelQ2.Reset();
                        prelQ2.SetRange("No.", TenderNo);
                        prelQ2.SetRange("Quote No.", purHead."No.");
                        if prelQ2.Find('-') then begin
                            repeat
                                prelQ2."Quote Status" := prelQ2."Quote Status"::Technical;
                                prelQ2.Modify();
                            until prelQ2.Next() = 0;
                        end;
                        techQ2.Reset();
                        techQ2.SetRange("No.", TenderNo);
                        techQ2.SetRange("Quote No.", prelQ2."Quote No.");
                        if techQ2.Find('-') then begin
                            repeat
                                techQ2."Quote Status" := techQ2."Quote Status"::Technical;
                                techQ2.Modify();
                            until techQ2.Next() = 0;
                        end;
                    until purHead.Next() = 0;
                end;
            end;
            Message('Preliminary Matrix Run Successfully');
        end;
    end;

    //Technical Evaluation
    procedure TechnicalEvaluation(TenderNo: Code[50])
    var
        AvgScore: Decimal;
        nos: Decimal;
        reqs: Record "Proc-Technical Qualif";
    begin
        rfq.Reset();
        rfq.SetRange("No.", TenderNo);
        rfq.SetRange("Has Evaluation", rfq."Has Evaluation"::Yes);
        rfq.SetRange("Technical Evaluation", rfq."Technical Evaluation"::Yes);
        if rfq.find('-') then begin
            rfq.CalcFields("Technical Passmark Score");
            Commiteeheader.Reset();
            Commiteeheader.SetRange("Tender/Quote No", TenderNo);
            if Commiteeheader.Find('-') then begin
                Commitee.Reset();
                Commitee.SetRange("Ref No", Commiteeheader."Ref No");
                Commitee.SetRange(Role, Commitee.Role::Secretary);
                if Commitee.Find('-') then begin
                    mem.Reset();
                    mem.SetRange("No.", TenderNo);
                    mem.SetRange("Staff No.", Commitee."Member No");
                    if mem.Find('-') then begin
                        Usersetup.Reset();
                        Usersetup.SetRange("Employee No.", mem."Staff No.");
                        if Usersetup.Find('-') then begin
                            if Usersetup."User ID" <> UserId then Error('%1 you are not the secretary', mem.Name);
                        end;
                    end;
                end /* else
                    Error('The evaluation committee has no secretary'); */
            end;
            purHead.Reset();
            purHead.SetRange("Request for Quote No.", TenderNo);
            purHead.SetRange("Quote Status", purHead."Quote Status"::"Prelim Qualif");
            if purHead.find('-') then begin
                repeat
                    techQ2.Reset();
                    techQ2.SetRange("No.", TenderNo);
                    techQ2.SetRange("Quote No.", purHead."No.");
                    techQ2.SetRange(Evaluated, false);
                    if techQ2.Find('-') then begin
                        Error('%1%2', 'Some Committee members have done Technical evaluation, e.g ', techQ2."Staff Name");
                    end;
                    techQ2.Reset();
                    techQ2.SetRange("No.", TenderNo);
                    techQ2.SetRange("Quote No.", purHead."No.");
                    if techQ2.Find('-') then begin
                        repeat
                            techQ2.CalcFields("Evaluation Commitee Count", "Tech Evaluation Max", "Tech Evaluation Min.Qual",
                             "Tech Evaluation Scored");
                            AvgScore := techQ2."Tech Evaluation Scored" / techQ2."Evaluation Commitee Count";
                            techQ2."Average Score" := AvgScore;
                            purHead."Technical Evaluation" := AvgScore;
                            purHead.Modify();
                            if (purHead."Technical Evaluation" >= rfq."Technical Passmark Score") then begin
                                purHead."Quote Status" := purHead."Quote Status"::"Tech Qualf";
                                techQ2."Quote Status" := techQ2."Quote Status"::Demonstration;
                                purHead.Modify();
                                techQ2.Modify();
                                DemoQ2.Reset();
                                DemoQ2.SetRange("No.", TenderNo);
                                DemoQ2.SetRange("Quote No.", techQ2."Quote No.");
                                if DemoQ2.Find('-') then begin
                                    repeat
                                        DemoQ2."Quote Status" := DemoQ2."Quote Status"::Demonstration;
                                        DemoQ2.Modify();
                                    until DemoQ2.Next() = 0;
                                end;
                            end
                            else begin
                                purHead."Quote Status" := purHead."Quote Status"::"Tech Disqualif";
                                techQ2."Quote Status" := techQ2."Quote Status"::Failed;
                                purHead.Modify();
                                techQ2.Modify();
                            end;

                        until techQ2.Next() = 0;
                    end;
                until purHead.Next() = 0;
            end;
        end;
        rfq.Reset();
        rfq.SetRange("No.", TenderNo);
        rfq.SetRange("Has Evaluation", rfq."Has Evaluation"::Yes);
        rfq.SetRange("Technical Evaluation", rfq."Technical Evaluation"::No);
        if rfq.find('-') then begin
            purHead.Reset();
            purHead.SetRange("Request for Quote No.", TenderNo);
            // purHead.SetRange("Quote No.", purHead."No.");
            purHead.SetRange("Quote Status", purHead."Quote Status"::"Prelim Qualif");
            if purHead.find('-') then begin
                repeat
                    purHead."Quote Status" := purHead."Quote Status"::"Tech Qualf";
                    purHead.Modify();
                    techQ2.Reset();
                    techQ2.SetRange("No.", TenderNo);
                    techQ2.SetRange("Staff No", techQ2."Staff No");
                    techQ2.SetRange("Quote No.", purHead."No.");
                    if techQ2.Find('-') then begin
                        repeat
                            techQ2."Quote Status" := techQ2."Quote Status"::Demonstration;
                            techQ2.Modify();
                        until techQ2.Next() = 0;
                    end;
                    DemoQ2.Reset();
                    DemoQ2.SetRange("No.", TenderNo);
                    DemoQ2.SetRange("Quote No.", purHead."No.");
                    if DemoQ2.Find('-') then begin
                        repeat
                            DemoQ2."Quote Status" := DemoQ2."Quote Status"::Demonstration;
                            DemoQ2.Modify();
                        until DemoQ2.Next() = 0;
                    end;

                until purHead.Next() = 0;
            end;
        end;
        Message('Technical Matrix Run Successfully');

    end;
    //Demonstration Evaluation
    procedure DemoEvaluation(TenderNo: Code[50])
    var
        AvgScore: Decimal;
        nos: Decimal;
        reqs: Record "Proc-demo Qualif";
    begin
        rfq.Reset();
        rfq.SetRange("No.", TenderNo);
        rfq.SetRange("Has Evaluation", rfq."Has Evaluation"::Yes);
        rfq.SetRange("Demonistration Evaluation", rfq."Demonistration Evaluation"::Yes);
        if rfq.Find('-') then begin
            rfq.CalcFields("Demo Passmark Score");
            Commiteeheader.Reset();
            Commiteeheader.SetRange("Tender/Quote No", TenderNo);
            if Commiteeheader.Find('-') then begin
                Commitee.Reset();
                Commitee.SetRange("Ref No", Commiteeheader."Ref No");
                Commitee.SetRange(Role, Commitee.Role::Secretary);
                if Commitee.Find('-') then begin
                    mem.Reset();
                    mem.SetRange("No.", TenderNo);
                    mem.SetRange("Staff No.", Commitee."Member No");
                    if mem.Find('-') then begin
                        Usersetup.Reset();
                        Usersetup.SetRange("Employee No.", mem."Staff No.");
                        if Usersetup.Find('-') then begin
                            if Usersetup."User ID" <> UserId then Error('%1 you are not the secretary', mem.Name);
                        end;
                    end;
                end /* else
                    Error('The evaluation committee has no secretary'); */
            end;
            purHead.Reset();
            purHead.SetRange("Request for Quote No.", TenderNo);
            purHead.SetRange("Quote Status", purHead."Quote Status"::"Tech Qualf");
            if purHead.find('-') then begin
                repeat
                    DemoQ2.Reset();
                    DemoQ2.SetRange("No.", TenderNo);
                    DemoQ2.SetRange("Quote No.", purHead."No.");
                    DemoQ2.SetRange(Evaluated, false);
                    if DemoQ2.Find('-') then begin
                        Error('Some Committee members have not scored Demo Qualification, e.g %1', DemoQ2."Staff Name");
                    end;
                    DemoQ2.Reset();
                    DemoQ2.SetRange("No.", TenderNo);
                    DemoQ2.SetRange("Quote No.", purHead."No.");
                    if DemoQ2.Find('-') then begin
                        repeat
                            DemoQ2.CalcFields("Evaluation Commitee Count", "Tech Evaluation Max",
                             "Tech Evaluation Min.Qual", "Tech Evaluation Scored");
                            AvgScore := DemoQ2."Tech Evaluation Scored" / DemoQ2."Evaluation Commitee Count";
                            DemoQ2."Average Score" := AvgScore;
                            purHead."Demo Evaluation" := AvgScore;
                            purHead.Modify();
                            if purHead."Demo Evaluation" >= rfq."Demo Passmark Score" then begin
                                purHead."Quote Status" := purHead."Quote Status"::"Demo Qualif";
                                DemoQ2."Quote Status" := DemoQ2."Quote Status"::Financials;
                                DemoQ2.Modify();
                                purHead.Modify();
                            end else begin
                                purHead."Quote Status" := purHead."Quote Status"::"Demo Disqualif";
                                DemoQ2."Quote Status" := DemoQ2."Quote Status"::Failed;
                                DemoQ2.Modify();
                                purHead.Modify();
                            end;
                        until DemoQ2.Next() = 0;
                    end;
                until purHead.Next() = 0;
            end;
        end;
        rfq.Reset();
        rfq.SetRange("No.", TenderNo);
        rfq.SetRange("Has Evaluation", rfq."Has Evaluation"::Yes);
        rfq.SetRange("Demonistration Evaluation", rfq."Demonistration Evaluation"::No);
        if rfq.Find('-') then begin
            purHead.Reset();
            purHead.SetRange("Request for Quote No.", TenderNo);
            purHead.SetRange("Quote Status", purHead."Quote Status"::"Tech Qualf");
            if purHead.find('-') then begin
                repeat
                    purHead."Quote Status" := purHead."Quote Status"::"Demo Qualif";
                    purHead.Modify();
                    DemoQ2.Reset();
                    DemoQ2.SetRange("No.", TenderNo);
                    DemoQ2.SetRange("Quote No.", purHead."No.");
                    if DemoQ2.Find('-') then begin
                        repeat
                            DemoQ2."Quote Status" := DemoQ2."Quote Status"::Financials;
                            DemoQ2.Modify();
                        until DemoQ2.Next() = 0;
                    end;
                until purHead.Next() = 0;
            end;
        end;
        Message('Demonstration Matrix Run Successfully');
    end;
    // Financial Evaluation
    procedure FinancialEvaluation(TenderNo: Code[50])
    var
        QAmount: Decimal;
        LstQuoted: Decimal;
    begin
        rfq.Reset();
        rfq.SetRange("No.", TenderNo);
        rfq.SetRange("Has Evaluation", rfq."Has Evaluation"::Yes);
        rfq.SetRange("Financial Evaluation", rfq."Financial Evaluation"::Yes);
        if rfq.Find('-') then begin
            rfq.CalcFields("Financial Evaluation Score");
            Commiteeheader.Reset();
            Commiteeheader.SetRange("Tender/Quote No", TenderNo);
            if Commiteeheader.Find('-') then begin
                Commitee.Reset();
                Commitee.SetRange("Ref No", Commiteeheader."Ref No");
                Commitee.SetRange(Role, Commitee.Role::Secretary);
                if Commitee.Find('-') then begin
                    mem.Reset();
                    mem.SetRange("No.", TenderNo);
                    mem.SetRange("Staff No.", Commitee."Member No");
                    if mem.Find('-') then begin
                        Usersetup.Reset();
                        Usersetup.SetRange("Employee No.", mem."Staff No.");
                        if Usersetup.Find('-') then begin
                            if Usersetup."User ID" <> UserId then Error('%1 you are not the secretary', mem.Name);
                        end;
                    end;
                end /* else
                    Error('The evaluation committee has no secretary'); */
            end;
            FinQ2.Reset();
            FinQ2.SetRange("No.", TenderNo);
            if FinQ2.Find('-') then
                FinQ2.DeleteAll();
            purHead.Reset();
            purHead.SetRange("Request for Quote No.", TenderNo);
            purHead.SetRange("Quote Status", purHead."Quote Status"::"Demo Qualif");
            if purHead.find('-') then begin
                repeat
                    prlines.Reset();
                    prlines.SetRange("Document No.", purHead."No.");
                    if prlines.Find('-') then begin
                        prlines.CalcSums("Line Amount");
                        QAmount := prlines."Line Amount";
                        if QAmount <= rfq."Financial Evaluation Score" then begin
                            purHead."Quote Status" := purhead."Quote Status"::"Fin Qualif";
                            purHead."Financial Score" := QAmount;
                            purHead.Modify();
                            FinQ2.Reset();
                            FinQ2.SetRange("No.", TenderNo);
                            FinQ2.SetRange("Quote No.", phead."No.");
                            if not FinQ2.Find('-') then begin
                                FinQ2.Init();
                                FinQ2."No." := TenderNo;
                                FinQ2."Quote No." := phead."No.";
                                FinQ2."Budgeted Amount" := rfq."Financial Evaluation Score";
                                FinQ2."Budgeted Amount" := FinQ1."Budgeted Amount";
                                FinQ2."Quoted Amount" := QAmount;
                                FinQ2.Score := QAmount;
                                FinQ2.Description := phead."Buy-from Vendor Name";
                                FinQ2."Quote Status" := FinQ2."Quote Status"::Financials;
                                FinQ2.Insert();
                            end;
                        end
                        else begin
                            purHead."Quote Status" := purhead."Quote Status"::"Fin Disqualif";
                            purHead."Financial Score" := QAmount;
                            purHead.Modify();
                            FinQ2.Reset();
                            FinQ2.SetRange("No.", TenderNo);
                            FinQ2.SetRange("Quote No.", phead."No.");
                            if not FinQ2.Find('-') then begin
                                FinQ2.Init();
                                FinQ2."No." := TenderNo;
                                FinQ2."Quote No." := phead."No.";
                                FinQ2."Budgeted Amount" := FinQ1."Budgeted Amount";
                                FinQ2."Budgeted Amount" := rfq."Financial Evaluation Score";
                                FinQ2."Quoted Amount" := QAmount;
                                FinQ2.Score := QAmount;
                                FinQ2.Description := phead."Buy-from Vendor Name";
                                FinQ2."Quote Status" := FinQ2."Quote Status"::failed;
                                FinQ2.Insert();
                            end;
                        end;
                    end;
                until purHead.Next() = 0;
            end;
        end;
        rfq.Reset();
        rfq.SetRange("No.", TenderNo);
        rfq.SetRange("Has Evaluation", rfq."Has Evaluation"::Yes);
        rfq.SetRange("Financial Evaluation", rfq."Financial Evaluation"::No);
        if rfq.Find('-') then begin
            purHead.Reset();
            purHead.SetRange("Request for Quote No.", TenderNo);
            purHead.SetRange("Quote Status", purHead."Quote Status"::"Demo Qualif");
            if purHead.find('-') then begin
                repeat
                    purHead."Quote Status" := purHead."Quote Status"::"Fin Qualif";
                    purHead.Modify();
                    FinQ2.Reset();
                    FinQ2.SetRange("No.", TenderNo);
                    FinQ2.SetRange("Quote No.", phead."No.");
                    if not FinQ2.Find('-') then begin
                        FinQ2.Init();
                        FinQ2."No." := TenderNo;
                        FinQ2."Quote No." := phead."No.";
                        FinQ2."Budgeted Amount" := rfq."Financial Evaluation Score";
                        FinQ2."Budgeted Amount" := FinQ1."Budgeted Amount";
                        FinQ2."Quoted Amount" := QAmount;
                        FinQ2.Score := QAmount;
                        FinQ2.Description := phead."Buy-from Vendor Name";
                        FinQ2."Quote Status" := FinQ2."Quote Status"::Financials;
                        FinQ2.Insert();
                    end;
                until purHead.Next() = 0;
            end;
        end;
        Message('Financial Matrix Run Successfully');
    end;
    //Postqualification Evaluation
    procedure PostQualificationEvaluation(TenderNo: Code[50])
    var
        AvgScore: Decimal;
        nos: Decimal;
        Postq2: Record "Proc-Post Qualif";

    begin
        rfq.Reset();
        rfq.SetRange("No.", TenderNo);
        rfq.SetRange("Has Evaluation", rfq."Has Evaluation"::Yes);
        rfq.SetRange("Post-Qualification", rfq."Post-Qualification"::Yes);
        if rfq.find('-') then begin
            Commiteeheader.Reset();
            Commiteeheader.SetRange("Tender/Quote No", TenderNo);
            if Commiteeheader.Find('-') then begin
                Commitee.Reset();
                Commitee.SetRange("Ref No", Commiteeheader."Ref No");
                Commitee.SetRange(Role, Commitee.Role::Secretary);
                if Commitee.Find('-') then begin
                    mem.Reset();
                    mem.SetRange("No.", TenderNo);
                    mem.SetRange("Staff No.", Commitee."Member No");
                    if mem.Find('-') then begin
                        Usersetup.Reset();
                        Usersetup.SetRange("Employee No.", mem."Staff No.");
                        if Usersetup.Find('-') then begin
                            if Usersetup."User ID" <> UserId then Error('%1 you are not the secretary', mem.Name);
                        end;
                    end;
                end /* else
                    Error('The evaluation committee has no secretary'); */
            end;
            purHead.Reset();
            purHead.SetRange("Request for Quote No.", TenderNo);
            purHead.SetRange("Quote Status", purHead."Quote Status"::"Fin Qualif");
            if purHead.find('-') then begin
                repeat
                    prelQ2.Reset();
                    prelQ2.SetRange("No.", TenderNo);
                    prelQ2.SetRange("Quote No.", purHead."No.");
                    prelQ2.Setrange(Evaluated, false);
                    if prelQ2.Find('-') then begin
                        Error('%1%2', 'Some Committee members have not done preliminary evaluation, e.g ', prelQ2."Staff Name");
                    end;
                    prelQ2.Reset();
                    prelQ2.SetRange("No.", TenderNo);
                    prelQ2.SetRange("Quote No.", purHead."No.");
                    prelQ2.SetRange("Entry No.", prelQ2."Entry No.");
                    prelQ2.Setfilter(Scored, '=%1', prelQ2.Scored::"Requirement Met");
                    if prelQ2.Find('-') then begin
                        prelQ2.CalcFields(Evaluators);
                        Rmet := prelQ2.Count;
                        if (Rmet <> prelQ2.Evaluators) then Error('Scores for %1 are not same for all evaluators', prelQ2."Quote No.");
                    end;
                    prelQ2.Reset();
                    prelQ2.SetRange("No.", TenderNo);
                    prelQ2.SetRange("Quote No.", purHead."No.");
                    prelQ2.SetRange("Entry No.", prelQ2."Entry No.");
                    prelQ2.Setfilter(Scored, '=%1', prelQ2.Scored::"Requirement Not Met");
                    if prelQ2.Find('-') then begin
                        prelQ2.CalcFields(Evaluators);
                        Rnmet := prelQ2.Count;
                        if (Rnmet <> prelQ2.Evaluators) then Error('Scores for %1 are not same for all evaluators', prelQ2."Quote No.");
                    end;

                    prelQ2.Reset();
                    prelQ2.SetRange("No.", TenderNo);
                    prelQ2.SetRange("Quote No.", purHead."No.");
                    if prelQ2.Find('-') then begin
                        if prelQ2.Scored = prelQ2.Scored::"Requirement Not Met" then
                            purHead."Quote Status" := purHead."Quote Status"::"Prelim DisQualif"
                        else
                            if prelQ2.Scored = prelQ2.Scored::"Requirement Met" then
                                purHead."Quote Status" := purHead."Quote Status"::"Prelim qualif";
                        purHead.Modify();
                    end;
                until purHead.Next() = 0;
            end;
        end;
        rfq.Reset();
        rfq.SetRange("No.", TenderNo);
        rfq.SetRange("Has Evaluation", rfq."Has Evaluation"::Yes);
        rfq.SetRange("Technical Evaluation", rfq."Preliminary Evaluation"::No);
        if rfq.find('-') then begin
            purHead.Reset();
            purHead.SetRange("Request for Quote No.", TenderNo);
            purHead.SetRange("Quote No.", purHead."No.");
            purHead.SetRange("Quote Status", purHead."Quote Status"::Submitted);
            if purHead.find('-') then begin
                repeat
                    purHead."Quote Status" := purHead."Quote Status"::"Prelim Qualif";
                    purHead.Modify();
                until purHead.Next() = 0;
            end;
        end;
        Message('Post-Qualification Matrix Run Successfully');

    end;

    procedure SendEvaluationConf(TenderNo: Code[50])
    begin
        confrm.Reset();
        confrm.SetRange("No.", TenderNo);
        if confrm.Find('-') then
            confrm.DeleteAll();
        eval.Reset();
        eval.SetRange("No.", TenderNo);
        if eval.Find('-') then begin
            committe.Reset();
            committe.SetRange("No.", TenderNo);
            committe.SetRange("Committee Type", committe."Committee Type"::"Evaluation Committee");
            if committe.Find('-') then begin
                repeat
                    confrm.Init();
                    confrm."No." := TenderNo;
                    confrm."Bidder No" := eval."Recommended for Award";
                    confrm."Staff No." := committe."Staff No.";
                    confrm.Validate("Staff No.");
                    confrm.Insert();
                until committe.Next() = 0;
            end
        end;
    end;



    //Tender
    procedure TenderEvalSetups(var phead: Record "Tender Submission Header")
    var
        rfq: Record "PROC-Purchase Quote Header";
        mem: Record "Proc-Committee Membership";
    begin
        rfq.Reset();
        rfq.SetRange("No.", phead."Request for Quote No.");
        // rfq.SetRange("Has Evaluation", rfq."Has Evaluation"::Yes);
        if rfq.Find('-') then begin
            mem.Reset();
            mem.SetRange("No.", rfq."No.");
            mem.SetRange("Committee Type", mem."Committee Type"::"Evaluation Committee");
            mem.SetFilter("Entry No.", '<>%1', 0);
            if mem.Find('-') then begin
                repeat
                    // Message('%1%2%3', mem."Committee Type", ' ', mem.Name);

                    //Preliminary
                    prelQ1.Reset();
                    prelQ1.SetRange("No.", rfq."No.");
                    if prelQ1.Find('-') then begin
                        repeat
                            prelQ2.Reset();
                            //prelQ2.SetRange("Entry No.", prelQ1."Entry No.");
                            prelQ2.SetRange("No.", prelQ1."No.");
                            prelQ2.SetRange("Quote No.", phead."No.");
                            prelQ2.SetRange("Staff No", mem."Staff No.");
                            if not prelQ2.Find('-') then begin
                                prelQ2.Init();
                                prelQ2."Entry No." := prelQ1."Entry No.";
                                prelQ2."No." := prelQ1."No.";
                                prelQ2."Quote No." := phead."No.";
                                prelQ2.Description := prelQ1.Description;
                                prelQ2."Staff No" := mem."Staff No.";
                                prelQ2."Staff Name" := mem.Name;
                                prelQ2.Insert();

                            end;
                        until prelQ1.Next() = 0;
                    end;
                    //Technical
                    techQ1.Reset();
                    techQ1.SetRange("No.", rfq."No.");
                    if techQ1.Find('-') then begin
                        repeat
                            techQ2.Reset();
                            //techQ2.SetRange("Entry No.", techQ1."Entry No.");
                            techQ2.SetRange("No.", techQ1."No.");
                            techQ2.SetRange("Quote No.", phead."No.");
                            techQ2.SetRange("Staff No", mem."Staff No.");
                            if not techQ2.Find('-') then begin
                                techQ2.Init();
                                techQ2."Entry No." := techQ1."Entry No.";
                                techQ2."No." := techQ1."No.";
                                techQ2."Quote No." := phead."No.";
                                techQ2.Description := techQ1.Description;
                                techQ2."Staff No" := mem."Staff No.";
                                techQ2."Staff Name" := mem.Name;
                                techQ2."Maximum Score" := techQ1."Maximum Score";
                                techQ2."Satisfactory Score" := techQ1."Satisfactory Score";
                                techQ2.Insert();
                            end;
                        until techQ1.Next() = 0;
                    end;

                    //Demo
                    DemoQ1.Reset();
                    DemoQ1.SetRange("No.", rfq."No.");
                    if DemoQ1.Find('-') then begin
                        repeat
                            DemoQ2.Reset();
                            //DemoQ2.SetRange("Entry No.", DemoQ1."Entry No.");
                            DemoQ2.SetRange("No.", DemoQ1."No.");
                            DemoQ2.SetRange("Quote No.", phead."No.");
                            DemoQ2.SetRange("Staff No", mem."Staff No.");
                            if not DemoQ2.Find('-') then begin

                                DemoQ2.Init();
                                DemoQ2."Entry No." := DemoQ1."Entry No.";
                                DemoQ2."No." := DemoQ1."No.";
                                DemoQ2."Quote No." := phead."No.";
                                DemoQ2.Description := DemoQ1.Description;
                                DemoQ2."Staff No" := mem."Staff No.";
                                DemoQ2."Staff Name" := mem.Name;
                                DemoQ2."Maximum Score" := DemoQ1."Maximum Score";
                                DemoQ2."Satisfactory Score" := DemoQ1."Satisfactory Score";
                                DemoQ2.Insert();


                            end;
                        until DemoQ1.Next() = 0;
                    end;

                until mem.Next() = 0;
            end;

            FinQ1.Reset();
            FinQ1.SetRange("No.", rfq."No.");
            if FinQ1.Find('-') then begin
                repeat
                    FinQ2.Reset();
                    FinQ2.SetRange("Entry No.", FinQ1."Entry No.");
                    FinQ2.SetRange("No.", FinQ1."No.");
                    FinQ2.SetRange("Quote No.", phead."No.");
                    if not FinQ2.Find('-') then begin

                        FinQ2.Init();
                        FinQ2."Entry No." := FinQ1."Entry No.";
                        FinQ2."No." := FinQ1."No.";
                        FinQ2."Quote No." := phead."No.";
                        FinQ2."Budgeted Amount" := FinQ1."Budgeted Amount";
                        FinQ2.Description := FinQ1.Description;
                        if FinQ2."Budgeted Amount" <> 0 then
                            FinQ2.Insert();
                    end;

                until FinQ1.Next() = 0;
            end;

        end;




    end;

    procedure TenderPreliminaryEvaluation(var rfq: Record "PROC-Purchase Quote Header")
    begin
        purHead.Reset();
        purHead.SetRange("Request for Quote No.", rfq."No.");
        purHead.SetRange("Quote Status", purHead."Quote Status"::Submitted);
        if purHead.find('-') then begin
            repeat
                prelQ2.Reset();
                prelQ2.SetRange("No.", rfq."No.");
                prelQ2.SetFilter(Scored, '%1', prelQ2.Scored::" ");
                if prelQ2.Find('-') then begin
                    Error('Some Committee members have not evaluated preliminary Qualification, e.g %1 ', prelQ2."Staff Name");
                end;
                prelQ2.Reset();
                prelQ2.SetRange("No.", rfq."No.");
                prelQ2.SetRange("Quote No.", prelQ2."Quote No.");
                if prelQ2.Find('-') then begin
                    if prelQ2.Scored = prelQ2.Scored::"Requirement Met" then
                        purHead."Quote Status" := purHead."Quote Status"::"Prelim Qualif"
                    else
                        if prelQ2.Scored = prelQ2.Scored::"Requirement Not Met" then
                            purHead."Quote Status" := purHead."Quote Status"::"Prelim Disqualif";
                    purHead.Modify();
                end;
            until purHead.Next() = 0;
        end;
        Message('Preliminary Matrix Successfully Done');
    end;

    procedure TenderTechnicalEvaluation(var rfq: Record "PROC-Purchase Quote Header")
    begin
        Tsubmission.Reset();
        Tsubmission.SetRange("Request for Quote No.", rfq."No.");
        Tsubmission.SetRange("Bid Status", Tsubmission."Bid Status"::"Prelim Qualif");
        if Tsubmission.find('-') then begin
            repeat
                techQ2.Reset();
                techQ2.SetRange("No.", rfq."No.");
                techQ2.SetRange(Evaluated, false);
                if techQ2.Find('-') then begin
                    Error('%1%2', 'Some Committee members have not scored Technical Qualification, e.g ', techQ2."Staff Name");
                end;
                techQ2.Reset();
                techQ2.SetRange("No.", rfq."No.");
                techQ2.SetRange(Evaluated, true);
                if techQ2.Find('-') then begin
                    techQ2.CalcFields("Evaluation Commitee Count", "Tech Evaluation Max", "Tech Evaluation Min.Qual", "Tech Evaluation Scored");
                    if ((techQ2."Tech Evaluation Scored") >= (techQ2."Tech Evaluation Min.Qual")) then begin
                        Tsubmission."Bid Status" := Tsubmission."Bid Status"::"Tech Qualf";
                        Tsubmission.Modify();
                    end else begin
                        Tsubmission."Bid Status" := Tsubmission."Bid Status"::"Tech Disqualif";
                        Tsubmission.Modify();
                    end;
                end;

            until Tsubmission.Next() = 0;

        end;
        Message('Matrix Run Successfully');
    end;

    procedure TenderDemoEvaluation(var rfq: Record "PROC-Purchase Quote Header")
    begin
        Tsubmission.Reset();
        Tsubmission.SetRange("Request for Quote No.", rfq."No.");
        Tsubmission.SetRange("Bid Status", Tsubmission."Bid Status"::"Tech Qualf");
        if Tsubmission.find('-') then begin
            repeat
                DemoQ2.Reset();
                DemoQ2.SetRange("No.", rfq."No.");
                DemoQ2.SetRange(Evaluated, false);
                if DemoQ2.Find('-') then begin
                    Error('%1%2', 'Some Committee members have not scored Demo Qualification, e.g ', DemoQ2."Staff Name");
                end;
                DemoQ2.Reset();
                DemoQ2.SetRange("No.", rfq."No.");
                DemoQ2.SetRange(Evaluated, true);
                if DemoQ2.Find('-') then begin
                    DemoQ2.CalcFields("Evaluation Commitee Count", "Tech Evaluation Max", "Tech Evaluation Min.Qual", "Tech Evaluation Scored");
                    if ((DemoQ2."Tech Evaluation Scored") >= (DemoQ2."Tech Evaluation Min.Qual")) then begin
                        Tsubmission."Bid Status" := Tsubmission."Bid Status"::"Demo Qualif";
                        Tsubmission.Modify();
                    end else begin
                        Tsubmission."Bid Status" := Tsubmission."Bid Status"::"Demo Disqualif";
                        Tsubmission.Modify();
                    end;
                end;

            until Tsubmission.Next() = 0;

        end;

        Message('Matrix Run Successfully');
    end;

    procedure TenderFinancialEvaluation(var rfq: Record "PROC-Purchase Quote Header")
    var
        QAmount: Decimal;
    begin
        Tsubmission.Reset();
        Tsubmission.SetRange("Request for Quote No.", rfq."No.");
        Tsubmission.SetRange("Bid Status", Tsubmission."Bid Status"::"Demo Qualif");
        if Tsubmission.find('-') then begin
            repeat

                FinQ2.Reset();
                FinQ2.SetRange("No.", rfq."No.");
                FinQ2.SetRange("Quote No.", Tsubmission."No.");
                if FinQ2.Find('-') then begin
                    FinQ2.CalcFields("Quoted Amount", "Tender Quoted Amount");

                    if ((FinQ2."Tender Quoted Amount" <= 0) or (FinQ2."Tender Quoted Amount" > FinQ2."Budgeted Amount")) then begin
                        Tsubmission."Bid Status" := Tsubmission."Bid Status"::"Fin Disqualif";
                        Tsubmission.Modify();
                    end;
                    if ((FinQ2."Tender Quoted Amount" <= FinQ2."Budgeted Amount") and (FinQ2."Tender Quoted Amount" > 0)) then begin
                        Tsubmission."Bid Status" := Tsubmission."Bid Status"::"Fin Qualif";
                        Tsubmission.Modify();
                    end


                end;
            until purHead.Next() = 0;

        end;

        Message('Matrix Run Successfully');
    end;

    //Awarding of tender
    procedure AwardTender(var Thead: Record "PROC-Purchase Quote Header1")
    var
        purheader: Record "Purchase Header";
        prlines: Record "Purchase Line";
        ven: Record Vendor;
        Bidders: Record "Tender Applicants Registration";
        purpay: Record "Purchases & Payables Setup";
        noseries: Codeunit NoSeriesManagement;
        tsline: Record "Tender Submission Lines";
        sno: Integer;
        purBids: Record "Tender Submission Header";

    begin
        Thead.TestField("Professional Opinion");
        Thead.TestField("Awarded BId");
        Thead.TestField("Bidder/Supplier");
        if Thead."Issue Order" = false then begin
            if Confirm('Award this Tender ?', true) = false then Error('Cancelled');
            ven.Reset();
            ven.SetRange("No.", Thead."Bidder/Supplier");
            if ven.Find('-') then begin
                purpay.get;
                purheader."No." := noseries.GetNextNo(purpay."Order Nos.", 0D, True);
                purheader."Buy-from Vendor No." := ven."No.";
                purheader.Validate("Buy-from Vendor No.");
                purheader."Shortcut Dimension 1 Code" := Thead."Shortcut Dimension 1 Code";
                purheader."Document Date" := Today;
                purheader."Posting Date" := Today;
                purheader."Due Date" := Today;
                purheader."Order Date" := Today;
                purheader."Procurement Request No." := Thead."Requisition No.";
                purheader."Request for Quote No." := Thead."No.";
                purheader."Quote No." := Thead."Quote No.";
                purheader."Responsibility Center" := '';
                purheader."Assigned User ID 2" := UserId;
                purheader."Winning Bid" := Thead."Awarded BId";
                purheader."Document Type" := purheader."Document Type"::Order;
                purheader.Insert();

                sno := 0;
                tsline.Reset();
                tsline.SetRange("Document No.", Thead."Awarded BId");
                if tsline.Find('-') then begin
                    repeat
                        sno := sno + 1;
                        prlines.init;
                        prlines."Document Type" := prlines."Document Type"::Order;
                        prlines."Document No." := purheader."No.";
                        prlines."Line No." := prlines."Line No." + sno;
                        prlines.Type := tsline.Type;
                        prlines.Validate(Type);
                        prlines."No." := tsline."No.";
                        prlines.Validate("No.");
                        prlines."Location Code" := 'GENERAL';
                        prlines.Validate("Location Code");
                        prlines.Description := CopyStr(tsline.Description, 1, 100);
                        prlines.Quantity := tsline.Quantity;
                        prlines.Validate(Quantity);
                        prlines."Direct Unit Cost" := tsline."Direct Unit Cost";
                        prlines.Validate("Direct Unit Cost");
                        prlines.Insert();
                    until tsline.Next() = 0;
                end;

                Thead."Order No." := purheader."No.";
                Thead."Issue Order" := true;
                Thead.Modify();

                purBids.Reset();
                purBids.SetRange("No.", Thead."Awarded BId");
                if purBids.Find('-') then begin
                    purBids."Bid Status" := purBids."Bid Status"::"Recommeded Award";
                    purBids.Modify();
                end;

                Page.Run(Page::"Purchase Order", purheader);
            end else begin
                //Vendor No does not exist
                Bidders.Reset();
                Bidders.SetRange("No.", Thead."Bidder/Supplier");
                Bidders.SetFilter("Vendor No.", '%1', '');
                if Bidders.Find('-') then begin
                    purpay.get;
                    ven.Init();
                    ven."No." := noseries.GetNextNo(purpay."Vendor Nos.", 0D, True);
                    ven.Validate("No.");
                    ven.Name := Bidders.Name;
                    ven."Gen. Bus. Posting Group" := 'DOMESTIC';
                    ven."VAT Bus. Posting Group" := 'ZERO VAT';
                    ven."Vendor Posting Group" := 'TRADE';
                    ven."Invoice Disc. Code" := ven."No.";
                    ven.Insert();
                    Bidders."Vendor No." := ven."No.";
                    Bidders.Modify();

                    purheader.Init();
                    purheader."No." := noseries.GetNextNo(purpay."Order Nos.", 0D, True);
                    purheader."Buy-from Vendor No." := ven."No.";
                    purheader.Validate("Buy-from Vendor No.");
                    purheader."Shortcut Dimension 1 Code" := Thead."Shortcut Dimension 1 Code";
                    purheader."Document Date" := Today;
                    purheader."Posting Date" := Today;
                    purheader."Due Date" := Today;
                    purheader."Order Date" := Today;
                    purheader."Procurement Request No." := Thead."Requisition No.";
                    purheader."Request for Quote No." := Thead."No.";
                    purheader."Quote No." := Thead."Quote No.";
                    purheader."Responsibility Center" := '';
                    purheader."Assigned User ID 2" := UserId;
                    purheader."Winning Bid" := Thead."Awarded BId";
                    purheader."Document Type" := purheader."Document Type"::Order;
                    purheader.Insert();

                    sno := 0;
                    tsline.Reset();
                    tsline.SetRange("Document No.", Thead."Awarded BId");
                    if tsline.Find('-') then begin
                        repeat
                            sno := sno + 1;
                            prlines.init;
                            prlines."Document Type" := prlines."Document Type"::Order;
                            prlines."Document No." := purheader."No.";
                            prlines."Line No." := prlines."Line No." + sno;
                            prlines.Type := tsline.Type;
                            prlines."No." := tsline."No.";
                            prlines.Validate("No.");
                            prlines.Description := CopyStr(tsline.Description, 1, 100);
                            prlines.Quantity := tsline.Quantity;
                            prlines.Validate(Quantity);
                            prlines."Direct Unit Cost" := tsline."Direct Unit Cost";
                            prlines.Validate("Direct Unit Cost");
                            prlines.Insert();
                        until tsline.Next() = 0;
                    end;

                    Thead."Order No." := purheader."No.";
                    Thead."Issue Order" := true;
                    Thead.Modify();

                    purBids.Reset();
                    purBids.SetRange("No.", Thead."Awarded BId");
                    if purBids.Find('-') then begin
                        purBids."Bid Status" := purBids."Bid Status"::"Recommeded Award";
                        purBids.Modify();
                    end;

                    Page.Run(Page::"Purchase Order", purheader);
                end;
                //Vendor number already exist
                Bidders.Reset();
                Bidders.SetRange("No.", Thead."Bidder/Supplier");
                Bidders.SetFilter("Vendor No.", '%1', '');
                if Bidders.Find('-') then begin

                    ven.Init();
                    ven."No." := Bidders."Vendor No.";
                    ven.Validate("No.");
                    ven.Name := Bidders.Name;
                    ven."Gen. Bus. Posting Group" := 'DOMESTIC';
                    ven."VAT Bus. Posting Group" := 'ZERO VAT';
                    ven."Vendor Posting Group" := 'TRADE';
                    ven."Invoice Disc. Code" := ven."No.";
                    ven.Insert();

                    purpay.get;
                    purheader.Init();
                    purheader."No." := noseries.GetNextNo(purpay."Order Nos.", 0D, True);
                    purheader."Buy-from Vendor No." := ven."No.";
                    purheader.Validate("Buy-from Vendor No.");
                    purheader."Shortcut Dimension 1 Code" := Thead."Shortcut Dimension 1 Code";
                    purheader."Document Date" := Today;
                    purheader."Posting Date" := Today;
                    purheader."Due Date" := Today;
                    purheader."Order Date" := Today;
                    purheader."Procurement Request No." := Thead."Requisition No.";
                    purheader."Request for Quote No." := Thead."No.";
                    purheader."Quote No." := Thead."Quote No.";
                    purheader."Responsibility Center" := '';
                    purheader."Assigned User ID 2" := UserId;
                    purheader."Winning Bid" := Thead."Awarded BId";
                    purheader."Document Type" := purheader."Document Type"::Order;
                    purheader.Insert();

                    sno := 0;
                    tsline.Reset();
                    tsline.SetRange("Document No.", Thead."Awarded BId");
                    if tsline.Find('-') then begin
                        repeat
                            sno := sno + 1;
                            prlines.init;
                            prlines."Document Type" := prlines."Document Type"::Order;
                            prlines."Document No." := purheader."No.";
                            prlines."Line No." := prlines."Line No." + sno;
                            prlines.Type := tsline.Type;
                            prlines."No." := tsline."No.";
                            prlines.Validate("No.");
                            prlines.Description := CopyStr(tsline.Description, 1, 100);
                            prlines.Quantity := tsline.Quantity;
                            prlines.Validate(Quantity);
                            prlines."Direct Unit Cost" := tsline."Direct Unit Cost";
                            prlines.Validate("Direct Unit Cost");
                            prlines.Insert();
                        until tsline.Next() = 0;
                    end;

                    Thead."Order No." := purheader."No.";
                    Thead."Issue Order" := true;
                    Thead.Modify();

                    purBids.Reset();
                    purBids.SetRange("No.", Thead."Awarded BId");
                    if purBids.Find('-') then begin
                        purBids."Bid Status" := purBids."Bid Status"::"Recommeded Award";
                        purBids.Modify();
                    end;

                    Page.Run(Page::"Purchase Order", purheader);
                end

            end;
            Thead."Issue Order" := true;
            Thead.Modify();
        end else begin
            purheader.Reset();
            purheader.SetRange("No.", Thead."Order No.");
            Page.Run(Page::"Purchase Order", purheader);
        end;
    end;


    procedure GenerateTotierBid(var header: Record "PROC-Purchase Quote Header1")
    var
        qlines: Record "PROC-Purchase Quote Line";
        tsheader: Record "Tender Submission Header";
        tsline: Record "Tender Submission Lines";
        // noseries: Codeunit NoSeriesManagement;
        prpay: Record "Purchases & Payables Setup";
        sno: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        sno := 0;
        tsheader.Init();
        prpay.get;
        tsheader."No." := NoSeriesMgt.GetNextNo(prpay."Tender Submission", 0D, True);
        tsheader."Tender No." := header."No.";
        tsheader."Request for Quote No." := header."No.";
        tsheader."Posting Description" := header.Description;
        tsheader."Procurement methods" := header."Procurement methods";
        tsheader."Request for Quote No." := header."Requisition No.";
        tsheader."Bid Status" := tsheader."Bid Status"::Submitted;
        tsheader."Expected Closing Date" := header."Expected Closing Date";
        tsheader."Expected Opening Date" := header."Expected Opening Date";
        tsheader."Bidder No" := header."Vendor Quote No.";
        tsheader.Insert();

        qlines.Reset();
        qlines.SetRange("Document No.", header."No.");
        if qlines.Find('-') then begin
            repeat
                sno := sno + 1;
                tsline.Init();
                tsline."Document Type" := tsline."Document Type"::Quote;
                tsline."Tender No." := header."No.";
                tsline."RFQ No." := header."Requisition No.";
                tsline.Description := qlines.Description;
                tsline."Document No." := tsheader."No.";
                tsline."Line No." := tsline."Line No." + sno;
                tsline.Validate("Line No.");
                tsline."No." := qlines."No.";
                tsline."Buy-from Bidder No." := header."Vendor Quote No.";
                tsline."Unit of Measure" := qlines."Unit of Measure Code";
                tsline.Quantity := qlines.Quantity;
                tsline."Type" := qlines."Type";
                tsline."Document Date" := Today;
                tsline.Insert();

            until qlines.Next() = 0;

        end;
        //  Page.Run(Page::"Tender Tier Submission Header", tsheader);

    end;

    //Evaluation Report
    procedure EvaluationReport(var header: Record "PROC-Purchase Quote Header1")
    var
        eval: Record "Proc Evaluation Report";
        confrm: Record "Proc-Confirm Recommended";
        committe: Record "Proc-Committee Membership";
        Pheader: Record "Purchase Header";
    begin
        eval.Reset();
        eval.SetRange("No.", header."No.");
        if not eval.Find('-') then begin
            eval.Init();
            eval."No." := header."No.";
            eval."Closing Date" := header."Expected Closing Date";
            eval."Openning Date" := header."Expected Opening Date";
            eval."Requisition No." := header."Requisition No.";
            eval."Procurement Methods" := header."Procurement methods";
            eval.Insert();
            page.Run(Page::"Evaluation Report", eval);
        end else
            page.Run(Page::"Evaluation Report", eval);
    end;
    //Proffessional Opinion
    procedure ProffesionalOpinion(var header: Record "PROC-Purchase Quote Header1")
    var
        eval: Record "Proc Evaluation Report";
        confrm: Record "Proc-Confirm Recommended";
        pfoffon: Record "Proc Proffessional Opinion";
    begin
        // if Confirm('Initiate Opinion ?', true) = false then Error('Cancelled');

        eval.Reset();
        eval.SetRange("No.", header."No.");
        if eval.Find('-') then begin
            //if eval."Intention to Award" = false then Error('Intention to award has not been done!');
            eval.TestField("Recommended for Award");
            pfoffon.Reset();
            pfoffon.SetRange("No.", header."No.");
            if not pfoffon.Find('-') then begin
                confrm.Reset();
                confrm.SetRange("No.", header."No.");
                if confrm.Find('-') then begin
                    repeat
                        if confrm.Confirmed = false then Error('%1%2', confrm.Name, ' has not confirmed the bid/quote to be awarded');
                    until confrm.Next() = 0;
                    pfoffon.Init();
                    pfoffon."No." := header."No.";
                    pfoffon."Closing Date" := header."Expected Closing Date";
                    pfoffon."Openning Date" := header."Expected Opening Date";
                    pfoffon."Requisition No." := header."Requisition No.";
                    pfoffon."Procurement Methods" := header."Procurement methods";
                    pfoffon."Recommended for Award" := eval."Recommended for Award";
                    pfoffon."Bidder/Supplier" := eval."Bidder/Supplier";
                    pfoffon."Created By" := UserId;
                    pfoffon."Date Created" := Today;
                    pfoffon.name := eval.name;
                    pfoffon.Insert();
                    Page.Run(Page::"PROC Proff Opinion.Quote", pfoffon);
                end else
                    Error('Evaluation committee has not confirmed the report');
            end else
                Page.Run(Page::"PROC Proff Opinion.Quote", pfoffon);
        end else
            Error('Evalution Report is missing');

    end;


    procedure GenerateQuote(var header: Record "PROC-Purchase Quote Header1")
    var
        qlines: Record "PROC-Purchase Quote Line";
        pheader: Record "Purchase Header";
        prLine: Record "Purchase Line";
        noseries: Codeunit NoSeriesManagement;
        prpay: Record "Purchases & Payables Setup";
        sno: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        sno := 0;
        pheader.Init();
        prpay.get;
        pheader."No." := NoSeriesMgt.GetNextNo(prpay."Tender Submission", 0D, True);
        pheader."Quote No." := header."No.";
        pheader."Request for Quote No." := header."No.";
        pheader."Posting Description" := header.Description;
        // Pheader."Procurement methods" := header."Procurement methods";
        pheader."RFQ No." := header."Requisition No.";
        pheader."Quote Status" := pheader."Quote Status"::Submitted;
        pheader."Document Type 2" := pheader."Document Type 2"::Quote;
        pheader.DocApprovalType := pheader.DocApprovalType::Quote;
        pheader."Procurement Method" := header."Procurement methods";
        pheader."Document Date" := Today;
        pheader."Due Date" := Today;
        pheader."Order Date" := Today;
        pheader."Expected Closing Date" := header."Expected Closing Date";
        pheader."Expected Opening Date" := header."Expected Opening Date";
        pheader."Document Type" := pheader."Document Type"::Quote;
        //tsheader."Buy-from Vendor No." := 'TENDER001';
        pheader.Insert();

        qlines.Reset();
        qlines.SetRange("Document No.", header."No.");
        if qlines.Find('-') then begin
            repeat
                sno := sno + 1;
                prLine.Init();
                prLine."Document Type" := prLine."Document Type"::Quote;
                prLine."Document No." := header."No.";
                prLine."RFQ No." := header."Requisition No.";
                prLine.Description := qlines.Description;
                prLine."Document No." := pheader."No.";
                prLine."Line No." := prLine."Line No." + sno;
                prLine.Validate("Line No.");
                prLine."No." := qlines."No.";
                prline."Unit of Measure" := qlines."Unit of Measure";
                prLine."Buy-from Vendor No." := pheader."Buy-from Vendor No.";
                prLine."Unit of Measure" := qlines."Unit of Measure Code";
                prLine.Quantity := qlines.Quantity;
                prLine.Validate(Quantity);
                prLine."Type" := qlines."Type";
                prLine."Order Date" := Today;
                prLine.Insert();
            until qlines.Next() = 0;
        end;
        Page.Run(Page::"Proc-Purchase Quote.Card", pheader);

    end;


    //award Quotation
    procedure AwardQuotation(var Thead: Record "Proc Proffessional Opinion")
    var
        purheader: Record "Purchase Header";
        prlines: Record "Purchase Line";
        ven: Record Vendor;
        purpay: Record "Purchases & Payables Setup";
        noseries: Codeunit NoSeriesManagement;
        qlines: Record "Purchase Line";
        sno: Integer;
        purQuotes: Record "Purchase Header";
        Thead1: Record "Purchase Header";

    begin
        Thead1.Reset();
        Thead1.SetRange("No.", Thead."Recommended for Award");
        if Thead1.find('-') then begin


            Thead.TestField("Proffessional Opinion");
            Thead.TestField("Recommended for Award");
            Thead.TestField("Bidder/Supplier");
            Thead.TestField("Accounting Officer");

            if Thead."Issue Order" = false then begin
                if Confirm('Award this Tender/Quote ?', true) = false then Error('Cancelled');
                // if UserId <> Thead."Accounting Officer" then Error('Your are not authorized');
                ven.Reset();
                ven.SetRange("No.", Thead."Bidder/Supplier");
                if ven.Find('-') then begin
                    purpay.get;
                    purheader."No." := noseries.GetNextNo(purpay."Order Nos.", 0D, True);
                    purheader."Buy-from Vendor No." := ven."No.";
                    purheader.Validate("Buy-from Vendor No.");
                    purheader."Shortcut Dimension 1 Code" := Thead1."Shortcut Dimension 1 Code";
                    purheader."Document Date" := Today;
                    purheader."Posting Date" := Today;
                    purheader."Due Date" := Today;
                    purheader."Order Date" := Today;
                    purheader."Procurement Request No." := Thead."Requisition No.";
                    purheader."Request for Quote No." := Thead."No.";
                    purheader."Quote No." := Thead1."Quote No.";
                    purheader."Responsibility Center" := '';
                    purheader."Assigned User ID 2" := UserId;
                    purheader."Winning Bid" := Thead."Recommended for Award";
                    purheader."Document Type" := purheader."Document Type"::Order;
                    purheader.Insert();
                    sno := 0;
                    qlines.Reset();
                    qlines.SetRange("Document No.", Thead."Recommended for Award");
                    if qlines.Find('-') then begin
                        repeat
                            sno := sno + 1;
                            prlines.init;
                            prlines."Document Type" := prlines."Document Type"::Order;
                            prlines."Document No." := purheader."No.";
                            prlines."Line No." := prlines."Line No." + sno;
                            prlines.Type := qlines.Type;
                            prlines."No." := qlines."No.";
                            prlines.Validate("No.");
                            prlines."Location Code" := qlines."Location Code";
                            prlines.Validate("Location Code");
                            prlines.Description := CopyStr(qlines.Description, 1, 100);
                            prlines.Quantity := qlines.Quantity;
                            prlines."Unit of Measure" := qlines."Unit of Measure";
                            prlines.Validate(Quantity);
                            prlines."Direct Unit Cost" := qlines."Direct Unit Cost";
                            prlines.Validate("Direct Unit Cost");
                            prlines.Insert();
                        until qlines.Next() = 0;
                    end;

                    Thead."Order No." := purheader."No.";

                    Thead."Issue Order" := true;
                    Thead.Modify();

                    purQuotes.Reset();
                    purQuotes.SetRange("No.", Thead."Recommended for Award");
                    if purQuotes.find('-') then begin
                        purQuotes."Quote Status" := purQuotes."Quote Status"::"Recommended Award";
                        purQuotes.Modify();
                    end;
                    Page.Run(Page::"Purchase Order", purheader);
                end;
            end else begin
                purheader.Reset();
                purheader.SetRange("No.", Thead."Order No.");
                Page.Run(Page::"Purchase Order", purheader);
            end;
        end;
    end;

    procedure validateProfOpinion()
    var
        setup: Record "User Setup";
    begin

        setup.Reset();
        setup.SetRange("User ID", UserId);
        setup.SetRange("Proffessional OP", false);
        if setup.Find('-') then begin
            Error('Not Authorized to perform this task');
        end;

    end;

    procedure validateAccOff()
    var
        setup: Record "User Setup";
    begin

        setup.Reset();
        setup.SetRange("User ID", UserId);
        setup.SetRange("Accounting Officer", false);
        if setup.Find('-') then
            Error('Not Authorized to perform this task');
    end;

    procedure AccountingOfficer(var pop: Record "Proc Proffessional Opinion")
    var
        setup: Record "User Setup";
    begin

        setup.Reset();
        setup.SetRange("Accounting Officer", true);
        if setup.Find('-') then begin
            pop."Accounting Officer" := setup."User ID";
            pop.Modify();
        end else
            Error('Ensure an accounting officer is setup on user setup');

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeCheckBuyFromVendorNo, '', false, false)]
    local procedure SkipVendorCheckForRequisition(PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        if PurchaseHeader.DocApprovalType = PurchaseHeader.DocApprovalType::Requisition then begin
            ishandled := true;
        end;
    end;

}

