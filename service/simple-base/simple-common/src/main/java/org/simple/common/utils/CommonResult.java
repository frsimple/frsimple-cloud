package org.simple.common.utils;

import lombok.Data;
import org.simple.common.constant.IErrorCode;
import org.simple.common.eum.ResultCode;


/**
 *  公共接口返回对象
 */

@Data
public class CommonResult<T> {
	private long code;
	private String msg;
	private T data;

	protected CommonResult() {
	}

	protected CommonResult(long code, String msg, T data) {
		this.code = code;
		this.msg = msg;
		this.data = data;
	}

	/**
	 * 成功返回结果
	 *
	 * @param data 获取的数据
	 */
	public static <T> CommonResult<T> success(T data) {
		return new CommonResult<T>(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getMsg(), data);
	}

	/**
	 * 成功返回结果
	 *
	 * @param data 获取的数据
	 * @param  message 提示信息
	 */
	public static <T> CommonResult<T> success(T data, String message) {
		return new CommonResult<T>(ResultCode.SUCCESS.getCode(), message, data);
	}

	public static <T> CommonResult<T> successNodata(String message) {
		return new CommonResult<T>(ResultCode.SUCCESS.getCode(), message,null);
	}

	/**
	 * 失败返回结果
	 * @param errorCode 错误码
	 */
	public static <T> CommonResult<T> failed(IErrorCode errorCode) {
		return new CommonResult<T>(errorCode.getCode(), errorCode.getMsg(), null);
	}

	/**
	 * 失败返回结果
	 * @param errorCode 错误码
	 * @param message 错误信息
	 */
	public static <T> CommonResult<T> failed(IErrorCode errorCode,String message) {
		return new CommonResult<T>(errorCode.getCode(), message, null);
	}

	/**
	 * 失败返回结果
	 * @param message 提示信息
	 */
	public static <T> CommonResult<T> failed(String message) {
		return new CommonResult<T>(ResultCode.FAILED.getCode(), message, null);
	}

	/**
	 * 失败返回结果
	 */
	public static <T> CommonResult<T> failed() {
		return failed(ResultCode.FAILED);
	}

	/**
	 * 参数验证失败返回结果
	 */
	public static <T> CommonResult<T> validateFailed() {
		return failed(ResultCode.VALIDATE_FAILED);
	}

	/**
	 * 参数验证失败返回结果
	 * @param message 提示信息
	 */
	public static <T> CommonResult<T> validateFailed(String message) {
		return new CommonResult<T>(ResultCode.VALIDATE_FAILED.getCode(), message, null);
	}

	/**
	 * 未登录返回结果
	 */
	public static <T> CommonResult<T> unauthorized(T data) {
		return new CommonResult<T>(ResultCode.UNAUTHORIZED.getCode(), ResultCode.UNAUTHORIZED.getMsg(), data);
	}

	/**
	 * 未授权返回结果
	 */
	public static <T> CommonResult<T> forbidden(T data) {
		return new CommonResult<T>(ResultCode.FORBIDDEN.getCode(), ResultCode.FORBIDDEN.getMsg(), data);
	}
}