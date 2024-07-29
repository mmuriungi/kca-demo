report 50013 "Purchase Requisition"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Purchase RequisitionsRep.rdl';

    dataset
    {
        dataitem(DataItem1; 38)
        {
            column(No_PurchaseHeader; "No.")
            {
            }
            column(PaytoName_PurchaseHeader; "Pay-to Name")
            {
            }
            column(PostingDesc; "Posting Description")
            {
            }
            column(ShortcutDimension1Code_PurchaseHeader; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_PurchaseHeader; "Shortcut Dimension 2 Code")
            {
            }
            column(PostingDate_PurchaseHeader; "Posting Date")
            {
            }
            column(SugestedSupplierNo; "Buy-from Vendor No.")
            {
            }
            column(SuggestedSuppName; "Buy-from Vendor Name")
            {
            }
            column(BuyFromAddress; "Buy-from Address" + ',' + "Buy-from Address 2" + '-' + "Buy-from City")
            {
            }
            column(BuyFromContact; "Buy-from Post Code")
            {
            }
            column(Dept; "Shortcut Dimension 2 Code")
            {
            }
            column(ReqDate; "Requested Receipt Date")
            {
            }
            column(sign1; usersetup3."User Signature")
            {
            }
            column(sign2; usersetup3."User Signature")
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
            column(picture; compInfo.Picture)
            {

            }
            column(compname; compInfo.Name)
            {

            }
            column(CompAddress; compInfo.Address)
            {

            }
            column(CompAddress2; compInfo."Address 2")
            {

            }
            dataitem(DataItem7; 39)
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
               "Document No." = FIELD("No.");
                column(Type_PurchaseLine; Type)
                {
                }
                column(No_PurchaseLine; "No.")
                {
                }
                column(Description_PurchaseLine; Description)
                {
                }
                column(Description2_PurchaseLine; "Description 2")
                {
                }
                column(UoM; "Unit of Measure Code")
                {
                }
                column(Quantity_PurchaseLine; Quantity)
                {
                }
                column(DirectUnitCost_PurchaseLine; "Direct Unit Cost")
                {
                }
                column(Amount_PurchaseLine; Amount)
                {
                }
            }

            dataitem(ApprovalEntry; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(ApproverID_ApprovalEntry; ApprovalEntry."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; format(ApprovalEntry."Last Date-Time Modified"))
                {
                }

                dataitem(UserSetUp; "User Setup")
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(Signature_UserSetup; UserSetUp."User Signature")
                    {
                    }
                    column(ApprovalDesignation_UserSetup; UserSetUp."Approval Title")
                    {
                    }
                }

                trigger OnPreDataItem()
                begin
                    ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                compInfo.get;
                compInfo.CalcFields(Picture);
                counted := 0;
                AppReq.RESET;
                AppReq.SETRANGE("Document No.", "No.");
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
            end;

            trigger OnPreDataItem()
            begin
                //
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
        counted: Integer;
        usersetup1: Record "User Setup";
        usersetup2: Record "User Setup";
        usersetup3: Record "User Setup";
        usersetup4: Record "User Setup";
        signDate1: DateTime;
        signDate2: DateTime;
        signDate3: DateTime;
        signDate4: DateTime;
        compInfo: Record "Company Information";
}

