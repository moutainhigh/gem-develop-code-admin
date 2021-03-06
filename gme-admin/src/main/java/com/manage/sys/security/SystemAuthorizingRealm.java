package com.manage.sys.security;


import java.sql.Timestamp;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.stereotype.Service;

import com.manage.base.util.Constants;
import com.manage.base.util.SpringContextUtil;
import com.manage.base.util.UserUtil;
import com.manage.sys.entity.SysUser;
import com.manage.sys.service.SysUserService;
import com.manage.sys.vo.SysUserVO;


/**
 * 系统安全认证实现类
 */
@Service("systemAuthorizingRealm")
public class SystemAuthorizingRealm extends AuthorizingRealm{
	private static final Log LOG = LogFactory.getLog(SystemAuthorizingRealm.class);
	private  SysUserService service;
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalcollection) {
		SysUser ll_sys_user=(SysUser)principalcollection.getPrimaryPrincipal();
		if(ll_sys_user==null){
			return null;
		}
		SimpleAuthorizationInfo info=(SimpleAuthorizationInfo)SecurityUtils.getSubject().getSession().getAttribute("user_permissions");
		if(info!=null){
			return info;
		}
		info = new SimpleAuthorizationInfo();
		List<String> permissions = UserUtil.getUserStringPermission(ll_sys_user.getRoleid());
		info.addStringPermissions(permissions);
		Session session=SecurityUtils.getSubject().getSession();
		session.setTimeout(7200000);
		session.setAttribute("user_permissions", info);
		session.setAttribute("SESSION_KEY", ll_sys_user);
		return info;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationtoken)throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) authenticationtoken;
		// 判断验证码
		Session session = SecurityUtils.getSubject().getSession();
		String code = (String)session.getAttribute(Constants.VALIDATE_CODE);
		if (token.getCaptcha() == null || !token.getCaptcha().toUpperCase().equals(code)){
			throw new CaptchaException("验证码错误.");
		}
		try{
			SysUserVO ll_sys_user_VO=new SysUserVO();
			ll_sys_user_VO.setUserName(token.getUsername());
			List<SysUser> list= getService().selectAll(ll_sys_user_VO);
			if (list == null || list.size()==0 || list.get(0)==null) {
				return null;
			} else {
				SysUser user=list.get(0);
				user.setLanguage(token.getLanguage());
				SimpleAuthenticationInfo authenticationInfo= new SimpleAuthenticationInfo(
						user,
		                user.getUserpwd(), //密码
		                ByteSource.Util.bytes(user.getUsername().toLowerCase()),
		                getName()  //realm name
						);
				return authenticationInfo;
			}
		}catch (Exception e) {
			LOG.error("登录发生系统异常",e);
			throw new AuthenticationException("登录失败.");
		}
	}
	
	
	public static void main(String[] args) {
		String algorithmName = "MD5";
		String source = "*****";
		int hashIterations = 2;
		ByteSource credentialsSalt = ByteSource.Util.bytes("admin");
		Object obj = new SimpleHash(algorithmName, source, credentialsSalt, hashIterations);
		System.out.println(obj);
	}
	
	/**
	 * 获取系统业务对象
	 */
	public SysUserService getService() {
		if (service == null){
			service = (SysUserService)SpringContextUtil.getBean("sysUserService");
		}
		return service;
	}
	
	/**
	 * 设定密码校验的Hash算法与迭代次数
	 */
	@PostConstruct
	public void initCredentialsMatcher() {
		HashedCredentialsMatcher matcher = new HashedCredentialsMatcher(Constants.PASSWORD_TYPE);
		matcher.setHashIterations(2);
		setCredentialsMatcher(matcher);
		setAuthenticationCachingEnabled(false);
		setCachingEnabled(false);
	}
	
}
