package net.$51zhiyuan.development.kidbridge.module.shiro;

import net.$51zhiyuan.development.kidbridge.module.Configuration;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.session.mgt.eis.AbstractSessionDAO;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;

import java.io.Serializable;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * Created by hkhl.cn on 2017/7/21.
 */
public class KidbridgeSessionDAO extends AbstractSessionDAO {

    private String sessionNamespace = Configuration.SYSTEM_SESSION_NAMESPACE;

    private RedisTemplate<Serializable,Object> redisTemplate;

    private Session storeSession(Serializable id, Session session) {
        if (id == null) {
            throw new NullPointerException("id argument cannot be null.");
        }
        ValueOperations valueOperations = this.redisTemplate.opsForValue();
        valueOperations.set(String.format("%s:%s",this.sessionNamespace,id),session,session.getTimeout(), TimeUnit.MILLISECONDS);
        return session;
    }


    @Override
    protected Serializable doCreate(Session session) {
        this.storeSession(session.getId(), session);
        return session.getId();
    }

    @Override
    public Session readSession(Serializable sessionId) throws UnknownSessionException {
        return this.doReadSession(sessionId);
    }

    @Override
    protected Session doReadSession(Serializable sessionId) {
        ValueOperations valueOperations = this.redisTemplate.opsForValue();
        Session session = (Session) valueOperations.get(String.format("%s:%s",this.sessionNamespace,sessionId));
        return session;
    }

    @Override
    public void update(Session session) throws UnknownSessionException {
        this.storeSession(session.getId(), session);
    }

    @Override
    public void delete(Session session) {
        if (session == null) {
            throw new NullPointerException("session argument cannot be null.");
        }
        Serializable id = session.getId();
        if (id != null) {
            this.redisTemplate.delete(String.format("%s:%s",this.sessionNamespace,id));
        }
    }

    @Override
    public Collection<Session> getActiveSessions() {
        HashOperations hashOperations = this.redisTemplate.opsForHash();
        List<Session> sessions = hashOperations.values(this.sessionNamespace);
        Collection<Session> values = sessions;
        if (CollectionUtils.isEmpty(values)) {
            return Collections.emptySet();
        } else {
            return Collections.unmodifiableCollection(values);
        }
    }

    public String getSessionNamespace() {
        return sessionNamespace;
    }

    public void setSessionNamespace(String sessionNamespace) {
        this.sessionNamespace = sessionNamespace;
    }

    public RedisTemplate<Serializable, Object> getRedisTemplate() {
        return redisTemplate;
    }

    public void setRedisTemplate(RedisTemplate<Serializable, Object> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }
}
