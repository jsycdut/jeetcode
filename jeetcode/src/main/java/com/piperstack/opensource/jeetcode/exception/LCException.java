package com.piperstack.opensource.jeetcode.exception;

public class LCException extends Exception {
    public LCException(String message) {
        super(message);
    }

    public LCException(String message, Throwable cause) {
        super(message, cause);
    }

    public LCException(Throwable cause) {
        super(cause);
    }
}
