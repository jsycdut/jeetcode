package com.piperstack.opensource.jeetcode.command;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

public class OperationsTest {

    private Operations operations;

    @Before
    public void init() {
        operations = Operations.getInstance();
    }

    @Test
    public void testRetrieveToken() {
        assertTrue(operations.retrieveToken());
    }

    @Test
    public void testLogin() {
        assertTrue(operations.login("", ""));
    }

    @Test
    public void testGetUserStatus() {
        operations.login("", "");
        assertNotNull(Operations.getInstance().getUserStatus());
    }
}
