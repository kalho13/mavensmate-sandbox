//========================================================
// Name: PocketCRMLeadController
// Type: Controller 
// Purpose: For Sencha Touch PocketCRM App
// Created by: Don Robins - www.ForceMentor.com
// Created on: August 1, 2012
// Copyright 2012 Outformations, Inc. 
//
// Rev #  Revised on  Revised by     Revision Description
// -----  ----------  -------------------------------------
//  1.0   08/01/2012  Don Robins      Initial Release
//=========================================================
public with sharing class PocketCRMLeadController {

    public PocketCRMLeadController() {}

    //========================================================================
    //INNER CLASSES
    //These support data request/response transport for remoting.
    //========================================================================

    // One of the parameters supplied by the DirectProxy read method.
    public class QueryRequest {
        Integer start;
        Integer recordCount;
        List < Map < String, String >> sortParams;

        Public QueryRequest() {
            start = 1;
            recordCount = 1;
        }

        Public QueryRequest(Integer pStart, Integer pRecordCount) {
            start = pStart;
            recordCount = pRecordCount;
        }
    }

    // The server response expected by the ExtJS DirectProxy API methods.
    public class Response {
        public Boolean success;
        public String errorMessage;
        public List < SObject > records;
        public Integer total;
        Response() {
            records = new List < SObject > ();
            success = true;
        }
    }
    //=======================================================================
    //PUBLIC CRUD REMOTE ACTION METHODS CALLED BY THE SENCHA PROXY
    //=======================================================================

    @RemoteAction
    public static Response Query(QueryRequest qr) {
        Response resp = new Response();
        List < Lead > LeadList;
        try {
            LeadList = getAllLeads();
        } catch (Exception e) {
            resp.success = false;
            resp.errorMessage = 'Query failed: ' + e.getMessage();
            return resp;
        }
        //Supply only the requested records
        for (Integer recno = qr.start;
        recno < (qr.start + qr.recordCount) && recno < LeadList.size(); ++recno) {

            resp.records.add(LeadList[recno]);
        }
        resp.total = LeadList.size();
        resp.success = true;
        return resp;
    }

    @RemoteAction
    public static Response Edit(List < Lead > LeadData) {
        return updateLeadList(LeadData);
    }

    @RemoteAction
    public static Response Add(List < Lead > LeadData) {
        return insertLeadList(LeadData);
    }

    @RemoteAction
    public static Response Destroy(List < Lead > LeadData) {
        System.debug('DESTROY CALLED BY SENCHA');
        return deleteLeadList(LeadData);
    }

    //=======================================================================
    //PRIVATE HELPER METHODS
    //=======================================================================

    private static List < Lead > getAllLeads() {

        return [SELECT
        FirstName, LastName, Company, Title, Phone, MobilePhone, Email, Status
        FROM Lead LIMIT 50];
    }

    private static Response insertLeadList(List < Lead > LeadData) {
        Response resp = new Response();
        resp.success = true;

        try {
            INSERT LeadData;
        } catch (Exception e) {
            resp.success = false;
            resp.errorMessage = 'Insert failed: ' + e.getMessage();
        }
        return resp;
    }

    private static Response updateLeadList(List < Lead > LeadData) {

        Response resp = new Response();
        resp.success = true;

        try {
            UPDATE LeadData;
        } catch (Exception e) {
            resp.success = false;
            resp.errorMessage = 'Update failed: ' + e.getMessage();
        }
        return resp;
    }

    private static Response deleteLeadList(List < Lead > LeadData) {
        System.debug('CALL TO DELETE A LEAD');

        Response resp = new Response();
        resp.success = true;

        try {
            DELETE LeadData;
        } catch (Exception e) {
            resp.success = false;
            resp.errorMessage = 'Deletion failed: ' + e.getMessage();
        }
        return resp;
    }
}