/// <summary>
/// Report Purchase Requisitions (ID 52178738).
/// </summary>
report 52178738 "Purchase Requisitions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Procurement/Reports/SSR/PurchaseRequisition.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(ph; "Purchase Header")
        {
            column(RequestedReceiptDate_ph; "Requested Receipt Date")
            {
            }
            column(AssignedUserID_ph; "Assigned User ID")
            {
            }
            column(UserId_ph; "User Id")
            {
            }
            column(approvaltime; approvaltime)
            {

            }
            column(senderdesignation; senderdesignation)
            {

            }
            column(No_PurchaseHeader; ph."No.")
            {
            }
            column(PaytoName_PurchaseHeader; ph."Pay-to Name")
            {
            }
            column(PostingDescription_PurchaseHeader; ph."Posting Description")
            {
            }
            column(ShortcutDimension1Code_PurchaseHeader; ph."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_PurchaseHeader; ph."Shortcut Dimension 2 Code")
            {
            }
            column(PostingDate_PurchaseHeader; ph."Posting Date")
            {
            }
            column(SugestedSupplierNo; ph."Buy-from Vendor No.")
            {
            }
            column(SuggestedSuppName; ph."Buy-from Vendor Name")
            {
            }
            column(BuyFromAddress; ph."Buy-from Address" + ',' + ph."Buy-from Address 2" + '-' + ph."Buy-from City")
            {
            }
            column(BuyFromContact; ph."Buy-from Post Code")
            {
            }
            column(Dept; ph."Shortcut Dimension 2 Code")
            {
            }
            column(ReqDate; ph."Order Date")
            {
            }
            column(sign1; usersetup1."User Signature")
            {
            }
            column(sign2; usersetup2."User Signature")
            {
            }
            column(sign3; usersetup3."User Signature")
            {
            }
            column(sign4; usersetup4."User Signature")
            {
            }
            column(datetime1; signDate1)
            {
            }
            column(datetime2; signDate2)
            {
            }
            column(datetime3; signDate3)
            {
            }
            column(datetime4; signDate4)
            {
            }
            column(AppTitle1; usersetup1."Approval Title")
            {
            }
            column(AppTitle2; usersetup2."Approval Title")
            {
            }
            column(AppTitle3; usersetup3."Approval Title")
            {
            }
            column(AppTitle4; usersetup4."Approval Title")
            {
            }
            column(logo; info.Picture)
            {

            }
            column(name; info.Name)
            {

            }
            column(name2; info."Name 2")
            {

            }
            column(Address; info.Address)
            {

            }
            column(Address2; info."Address 2")
            {

            }
            column(mail; info."E-Mail")
            {

            }
            column(url; info."Home Page")
            {

            }
            column(MemoDescription_ph; "Memo Description")
            {
            }

            dataitem(pl; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                column(Type_PurchaseLine; pl.Type)
                {
                }
                column(Description2_pl; "Description 2")
                {
                }
                column(Description3_pl; "Description 3")
                {
                }


                column(No_PurchaseLine; pl."No.")
                {
                }
                column(Description_PurchaseLine; pl.Description)
                {
                }
                column(UnitofMeasure_PurchaseLine; pl."Unit of Measure")
                {
                }
                column(Quantity_PurchaseLine; pl.Quantity)
                {
                }
                column(DirectUnitCost_PurchaseLine; pl."Direct Unit Cost")
                {
                }
                column(Amount_PurchaseLine; pl.Amount)
                {
                }
            }
            dataitem(ApprovalEntry; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = order(ascending) WHERE(Status = CONST(Approved));
                column(ApproverID_ApprovalEntry; ApprovalEntry."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; ApprovalEntry."Last Date-Time Modified")
                {
                }
                column(Status_ApprovalEntry; Status)
                {
                }
                column(Sender_ID; ApprovalEntry."Sender ID") { }

                dataitem(UserSetUp; "User Setup")
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(UserID_UserSetUp; "User ID")
                    {
                    }

                    column(Signature_UserSetup; UserSetUp."User Signature")
                    {
                    }
                    column(ApprovalDesignation_UserSetup; UserSetUp."Approval Title")
                    {
                    }


                    trigger OnPreDataItem()
                    begin
                        CalcFields("User Signature");
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        CalcFields("User Signature");
                    end;
                }
            }
            dataitem(ApprovalEntry2; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("Memo No");
                DataItemTableView = order(ascending) WHERE(Status = CONST(Approved));
                column(ApproverID_ApprovalEntry2; "Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry2; "Last Date-Time Modified")
                {
                }
                column(Status_ApprovalEntry2; Status)
                {
                }
                dataitem(UserSetUp8; "User Setup")
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(UserID_UserSetUp8; "User ID")
                    {
                    }
                    column(ApprovalDesignation_UserSetup8; "Approval Title")
                    {
                    }
                    column(UserSignature_UserSetUp8; "User Signature")
                    {
                    }
                    trigger OnPreDataItem()
                    begin
                        CalcFields("User Signature");
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        CalcFields("User Signature");
                    end;

                }
            }


            trigger OnAfterGetRecord()
            begin
                counted := 0;
                AppReq.RESET;
                AppReq.SETRANGE("Document No.", ph."No.");
                AppReq.SETRANGE("Approved The Document", TRUE);
                IF AppReq.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        counted := counted + 1;
                        IF counted = 1 THEN BEGIN
                            usersetup1.RESET;
                            usersetup1.SETRANGE(usersetup1."User ID", AppReq."Approver ID");
                            IF usersetup1.FIND('-') THEN BEGIN
                                usersetup1.CALCFIELDS("User Signature");
                                signDate1 := AppReq."Last Date-Time Modified";
                            END;
                        END ELSE
                            IF counted = 2 THEN BEGIN
                                usersetup2.RESET;
                                usersetup2.SETRANGE(usersetup2."User ID", AppReq."Approver ID");
                                IF usersetup2.FIND('-') THEN BEGIN
                                    usersetup2.CALCFIELDS("User Signature");
                                    signDate2 := AppReq."Last Date-Time Modified";
                                END;
                            END ELSE
                                IF counted = 3 THEN BEGIN
                                    usersetup3.RESET;
                                    usersetup3.SETRANGE(usersetup3."User ID", AppReq."Approver ID");
                                    IF usersetup3.FIND('-') THEN BEGIN
                                        usersetup3.CALCFIELDS("User Signature");
                                        signDate3 := AppReq."Last Date-Time Modified";
                                    END;
                                END ELSE
                                    IF counted = 4 THEN BEGIN
                                        usersetup4.RESET;
                                        usersetup4.SETRANGE(usersetup4."User ID", AppReq."Approver ID");
                                        IF usersetup4.FIND('-') THEN BEGIN
                                            usersetup4.CALCFIELDS("User Signature");
                                            signDate4 := AppReq."Last Date-Time Modified";
                                        END;
                                    END;

                    END;
                    UNTIL AppReq.NEXT = 0;
                END;
                if "Assigned User ID" = '' then begin
                    UserSetUp.Reset();
                    UserSetUp.SetRange("User ID", "User Id");
                    if UserSetUp.Find('-') then begin
                        senderdesignation := UserSetUp."Approval Title";
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetRange("Sender ID", "User Id");
                        if ApprovalEntry.Find('-') then begin
                            approvaltime := ApprovalEntry."Last Date-Time Modified";
                        end;
                    end;
                end else
                    if "Assigned User ID" <> '' then begin
                        UserSetUp.Reset();
                        UserSetUp.SetRange("User ID", "Assigned User ID");
                        if UserSetUp.Find('-') then begin
                            senderdesignation := UserSetUp."Approval Title";
                            ApprovalEntry.Reset();
                            ApprovalEntry.SetRange("Sender ID", "User Id");
                            if ApprovalEntry.Find('-') then begin
                                approvaltime := ApprovalEntry."Last Date-Time Modified";
                            end;
                        end;
                    end;

            end;

            trigger OnPreDataItem()
            begin
                info.Get();
                info.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        AppReq: Record "Approval Entry";
        senderdesignation: text[150];
        approvaltime: Datetime;
        info: Record "Company Information";
        memoheader: Record "FIN-Memo Header";
        counted: Integer;
        usersetup1: Record "User Setup";
        usersetup2: Record "User Setup";
        usersetup3: Record "User Setup";
        usersetup4: Record "User Setup";
        signDate1: DateTime;
        signDate2: DateTime;
        signDate3: DateTime;
        signDate4: DateTime;
        Memoapprover: Text[150];
        MemoapproverTime: DateTime;
        MemoapproverTitle: Text[150];
        MemoapproverStatus: Enum "Approval Status";

}
